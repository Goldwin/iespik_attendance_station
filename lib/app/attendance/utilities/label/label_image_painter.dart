import 'dart:convert';
import 'dart:ui';

import 'package:iespik_attendance_station/app/attendance/domain/entities/label/label_image_object.dart';

void paintLabelImage(LabelImageObject image, Canvas canvas, Size size) {
  Paint paint = Paint();
  final bytes = base64Decode(image.image);
  ImmutableBuffer.fromUint8List(bytes.buffer.asUint8List())
      .then((buffer) async {
    final descriptor = ImageDescriptor.raw(buffer,
        width: image.width.toInt(),
        height: image.height.toInt(),
        pixelFormat: PixelFormat.rgba8888);
    final codec = await descriptor.instantiateCodec();
    final frame = await codec.getNextFrame();
    canvas.drawImage(
        frame.image, Offset(image.position.left, image.position.top), paint);
  });

  //Image
  //canvas.drawImage(image, Offset(image.position.left, image.position.top), paint)
}
