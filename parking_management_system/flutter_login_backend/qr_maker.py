import sys
import qrcode
from PIL import Image
from io import BytesIO
import mysql.connector
reg_no = sys.argv[1]
phone_no = sys.argv[2]
qr = qrcode.QRCode(
    version=1,
    error_correction=qrcode.constants.ERROR_CORRECT_L,
    box_size=10,
    border=4,
)
qr_data = reg_no
qr.add_data(qr_data)
qr.make(fit=True)
qr_image = qr.make_image(fill_color="black", back_color="white")
qr_bytes = BytesIO()
qr_image.save(qr_bytes, format='JPEG')
qr_bytes = qr_bytes.getvalue()
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="parking_management",
)
cursor = conn.cursor()
query = "UPDATE user_information SET QR = %s WHERE phone = %s"
cursor.execute(query, (qr_bytes, phone_no))
conn.commit()
cursor.close()
conn.close()
