package org.iespik.printer

import java.io.File

interface Printer {
    fun getModel(): String
    fun getLocalName(): String
    fun print(file:File)
    fun toMap():Map<String, Any>
}