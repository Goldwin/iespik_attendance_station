package org.iespik.printer

data class PrintResult(
    val success: Boolean,
    val message: String
) {
    companion object {
        val InvalidPathError: PrintResult = PrintResult(false, "Invalid File Path")
        val PrinterNotFoundError: PrintResult = PrintResult(false, "Printer Not Found")
        val Success: PrintResult = PrintResult(true, "Success")
    }

    fun toMap(): Map<String, Any> {
        return mapOf<String, Any>("success" to success, "message" to message)
    }
}
