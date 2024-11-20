package org.iespik.printer

import android.graphics.BitmapFactory
import com.brother.sdk.lmprinter.Channel
import com.brother.sdk.lmprinter.OpenChannelError
import com.brother.sdk.lmprinter.PrintError
import com.brother.sdk.lmprinter.PrinterDriverGenerator
import com.brother.sdk.lmprinter.PrinterModel
import com.brother.sdk.lmprinter.setting.PrintImageSettings
import com.brother.sdk.lmprinter.setting.QLPrintSettings
import io.flutter.Log
import java.io.File

class BrotherPrinter(val channel: Channel) : Printer {
    private val modelName: String = channel.extraInfo[Channel.ExtraInfoKey.ModelName] ?: ""
    private val model: PrinterModel

    init {
        val str = modelName.replace('-', '_')
        var guessedModel = PrinterModel.QL_820NWB
        for (model in PrinterModel.values()) {
            if (str.startsWith(model.toString())) {
                guessedModel = model
                break
            }
        }
        this.model = guessedModel
    }

    override fun getModel(): String {
        return this.modelName
    }

    override fun getLocalName(): String {
        return channel.channelInfo
    }

    override fun print(file: File): PrintResult {
        val result = PrinterDriverGenerator.openChannel(channel)
        if (result.error.code != OpenChannelError.ErrorCode.NoError) {
            Log.e("LabelPrinter", "Error - Open Channel: " + result.error.code)
            return PrintResult(false, "Error - Open Channel: ${result.error.code}")
        }
        val driver = result.driver
        val settings = QLPrintSettings(model)

        val imageBitmap = BitmapFactory.decodeFile(file.path)

        Log.d("LabelPrinter", "File Path: ${file.path}")
        Log.d("LabelPrinter", "Image Size: ${imageBitmap.width} x ${imageBitmap.height}")
        Log.d("LabelPrinter", "Dir Path: ${file.parent}")

        settings.labelSize = QLPrintSettings.LabelSize.RollW29
        settings.isAutoCut = true
        settings.scaleMode = PrintImageSettings.ScaleMode.FitPageAspect
        settings.workPath = file.parent
        settings.imageRotation = PrintImageSettings.Rotation.Rotate90

        val printError = driver.printImage(imageBitmap, settings)

        return try {
            if (printError.code != PrintError.ErrorCode.NoError) {
                PrintResult(
                    false,
                    "Error - Print Image: ${printError.code} - ${printError.errorDescription}"
                )
            } else {
                PrintResult.Success
            }
        } finally {
            driver.closeChannel()
        }
    }

    override fun toMap(): Map<String, Any> {
        return mapOf<String, Any>("model" to getModel(), "localName" to getLocalName())
    }
}