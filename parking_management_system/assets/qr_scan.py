import cv2
a = cv2.QRCodeDetector()
file_name = "9892279383"
b, points, straight_qrcode =a.detectAndDecode(cv2.imread("images/"+file_name+".jpg"))
print(b)