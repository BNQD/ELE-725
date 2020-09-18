import cv2


image = cv2.imread('lena.jpg', 0);
cv2.imshow("image", image);
cv2.waitKey(0);