package org.iespik.printer

import com.brother.sdk.lmprinter.Channel
import com.brother.sdk.lmprinter.OpenChannelError
import com.brother.sdk.lmprinter.PrintError
import com.brother.sdk.lmprinter.PrinterDriverGenerator
import com.brother.sdk.lmprinter.PrinterModel
import com.brother.sdk.lmprinter.setting.QLPrintSettings
import io.flutter.Log
import java.io.File

class BrotherPrinter(
    private val channel: Channel,
) : Printer {

    override fun getModel(): String {
        return channel.extraInfo[Channel.ExtraInfoKey.ModelName] ?: ""
    }

    override fun getLocalName(): String {
        return channel.channelInfo
    }

    override fun print(file: File) {
        val result = PrinterDriverGenerator.openChannel(channel)
        if(result.error.code != OpenChannelError.ErrorCode.NoError) {
            Log.e("", "Error - Open Channel: " + result.error.code)
            return
        }
        val driver = result.driver
        val settings = QLPrintSettings(PrinterModel.valueOf(getModel()))

        settings.labelSize = QLPrintSettings.LabelSize.RollW12
        settings.isAutoCut = true

        val printError = driver.printImage(file.toString(), settings)

        if (printError.code != PrintError.ErrorCode.NoError) {
            Log.d("", "Error - Print Image: " + printError.code)
        }
        else {
            Log.d("", "Success - Print Image")
        }
        driver.closeChannel()
    }

    override fun toMap(): Map<String, Any> {
        return mapOf<String, Any>("model" to getModel(), "localName" to getLocalName())
    }
}