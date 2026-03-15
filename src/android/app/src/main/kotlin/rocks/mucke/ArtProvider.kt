package rocks.mucke

import android.content.ContentProvider
import android.content.ContentValues
import android.database.Cursor
import android.net.Uri
import android.os.ParcelFileDescriptor
import java.io.File
import java.io.FileNotFoundException

class ArtProvider : ContentProvider() {
    override fun onCreate() = true

    override fun query(
            uri: Uri,
            projection: Array<out String>?,
            selection: String?,
            selectionArgs: Array<out String>?,
            sortOrder: String?
    ): Cursor? = null

    override fun getType(uri: Uri): String? = "image/jpeg"

    override fun insert(uri: Uri, values: ContentValues?): Uri? = null

    override fun delete(uri: Uri, selection: String?, selectionArgs: Array<out String>?): Int = 0

    override fun update(
            uri: Uri,
            values: ContentValues?,
            selection: String?,
            selectionArgs: Array<out String>?
    ): Int = 0

    override fun openFile(uri: Uri, mode: String): ParcelFileDescriptor? {
        val path = uri.path ?: throw FileNotFoundException("No path provided")

        val file = File(path)
        val context = context ?: throw FileNotFoundException("Context is null")

        // Security check: restrict access to "files" or "app_flutter" dir
        val canonicalFile = file.canonicalFile
        val filesDir = context.filesDir.canonicalPath
        val dataDirDir = context.applicationInfo.dataDir
        val appFlutterDir = File(dataDirDir, "app_flutter").canonicalPath
        val plainFilesDir = File(dataDirDir, "files").canonicalPath

        if (!canonicalFile.path.startsWith(filesDir) &&
                        !canonicalFile.path.startsWith(appFlutterDir) &&
                        !canonicalFile.path.startsWith(plainFilesDir)
        ) {
            throw SecurityException("Files outside the allowed directories are not permitted")
        }

        if (!file.exists() || !file.canRead()) {
            throw FileNotFoundException("File not found or unreadable: " + uri.toString())
        }

        return ParcelFileDescriptor.open(file, ParcelFileDescriptor.MODE_READ_ONLY)
    }
}
