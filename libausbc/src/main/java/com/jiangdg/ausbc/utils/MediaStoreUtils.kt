package com.jiangdg.ausbc.utils

import android.Manifest
import android.content.ContentValues
import android.content.Context
import android.content.pm.PackageManager
import android.media.MediaScannerConnection
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import android.util.Log
import android.webkit.MimeTypeMap
import androidx.core.content.ContextCompat
import java.io.File
import java.io.FileInputStream
import java.util.Locale.getDefault
import kotlin.text.split

object MediaStoreUtils {
    private const val TAG = "MediaStoreUtils"

    fun saveMediaStore(file: File, context: Context, onResult: ((String, Uri) -> Unit)? = null) {
        if (!file.exists()) throw Exception("no find file")
        val mimeType = MimeTypeMap.getSingleton()
            .getMimeTypeFromExtension(file.extension.lowercase(getDefault()))
        if (mimeType == null) throw Exception("no find file mimeType")
        val mediaList = arrayOf("image", "video", "audio")
        if (!mediaList.contains(mimeType.split("/").first()))
            throw Exception("must image/video/audio file")
        val perG = if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            ContextCompat.checkSelfPermission(context, Manifest.permission.WRITE_EXTERNAL_STORAGE)
        } else {
            PackageManager.PERMISSION_GRANTED
        }
        if (perG != PackageManager.PERMISSION_GRANTED) {
//            throw Exception("must have WRITE_EXTERNAL_STORAGE permission")
            Log.w(TAG, "saveMediaStore failed, no have WRITE_EXTERNAL_STORAGE permission")
            Log.w(TAG, "saveMediaStore failed, no have WRITE_EXTERNAL_STORAGE permission")
            Log.w(TAG, "saveMediaStore failed, no have WRITE_EXTERNAL_STORAGE permission")
            return
        }
        val mediaDirs =
            arrayOf(
                Environment.DIRECTORY_PICTURES,
                Environment.DIRECTORY_MOVIES,
                Environment.DIRECTORY_MUSIC,
                Environment.DIRECTORY_DCIM,
            ).map { Environment.getExternalStoragePublicDirectory(it).absolutePath }
        val isInMediaDirs = mediaDirs.any { dir -> file.absolutePath.startsWith(dir) }
        if (isInMediaDirs) {
            MediaScannerConnection.scanFile(
                context,
                arrayOf(file.absolutePath),
                arrayOf(mimeType)
            ) { path, mediaUri ->
                Log.d(TAG, "saveMediaStore success: path-$path mediaUri-$mediaUri")
                onResult?.invoke(path, mediaUri)
            }
            return
        }
        val (path, mediaUri) = createMediaUri(mimeType, file.name, context)
        context.contentResolver?.openOutputStream(mediaUri)?.use { outputStream ->
            FileInputStream(file).use { fileInputStream ->
                val buffer = ByteArray(1024)
                var bytesRead: Int
                while (fileInputStream.read(buffer).also { bytesRead = it } > 0) {
                    outputStream.write(buffer, 0, bytesRead)
                }
                outputStream.flush()
            }
        }
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            MediaScannerConnection.scanFile(
                context,
                arrayOf(mediaUri.path),
                arrayOf(mimeType)
            ) { path, mediaUri ->
                Log.d(TAG, "saveMediaStore success: path-$path mediaUri-$mediaUri")
                onResult?.invoke(path, mediaUri)
            }
            return
        }
        Log.d(TAG, "saveMediaStore success: path-$path mediaUri-$mediaUri")
        onResult?.invoke(path, mediaUri)
    }

    fun createMediaUri(mimeType: String, fileName: String, context: Context): Pair<String, Uri> {
        val relativePath = when {
            mimeType.startsWith("video") -> Environment.DIRECTORY_MOVIES
            mimeType.startsWith("audio") -> Environment.DIRECTORY_MUSIC
            else -> Environment.DIRECTORY_PICTURES
        }
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            val storePath = Environment.getExternalStoragePublicDirectory(relativePath).absolutePath
            val appDir = File(storePath, context.packageName).apply {
                if (!exists()) mkdirs()
            }
            val file = File(appDir, fileName)
            return Pair(file.absolutePath, Uri.fromFile(file))
        }
        val contentUri = when {
            mimeType.startsWith("video") -> MediaStore.Video.Media.EXTERNAL_CONTENT_URI
            mimeType.startsWith("audio") -> MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
            else -> MediaStore.Images.Media.EXTERNAL_CONTENT_URI
        }
        val contentValues = ContentValues().apply {
            put(MediaStore.MediaColumns.DISPLAY_NAME, fileName)
            put(MediaStore.Images.Media.MIME_TYPE, mimeType)
            put(MediaStore.MediaColumns.RELATIVE_PATH, "${relativePath}/${context.packageName}")
        }
        return Pair(
            "${Environment.getExternalStoragePublicDirectory(relativePath)}/${context.packageName}/${fileName}",
            context.contentResolver?.insert(contentUri, contentValues)!!
        )
    }
}