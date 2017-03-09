
from PIL import Image
import cv2
import numpy
import collections
import operator
import glob

import numpy as np
import PIL


txt_path = "/Users/lindashen/Desktop/Gathered data/Margarate Qian/34 Genuinely Funny Tweets About The Oscars Best Picture Shitshow.txt"
screenshot_path = "/Users/lindashen/Desktop/34 Genuinely Funny Tweets About The Oscars Best Picture Shitshow.png"

txt_file = open(txt_path, "r")

percentage_list = []

img = Image.open(screenshot_path)
img = img.convert("RGB")

height = img.size[1]
width = img.size[0]
# print width, height
pixdata = img.load()

# print "width: " + str(width),  " height: " + str(height)
count = 0
for line in txt_file:
	count += 1
	if count is 1:
		continue
	else:
		tt = line.split(",")
    	percentage_list.append(int(round(float(tt[1].split("\\")[0]))))

# print percentage_list
# print len(percentage_list)

diction_ =  collections.Counter(percentage_list)

sorted_x = sorted(diction_.items(), key=operator.itemgetter(1))

# print sorted_x

size_ = int(height * 0.01)

red = Image.new('RGB',(width, size_),(250,0,0))

count = 0
previous = 0
previous_index = 0
for i in xrange(100):
	if i in diction_ :
		previous = i

		for index in xrange(len(sorted_x)):
			if sorted_x[index][0] == i:
				previous_index = index
		# #create a mask using RGBA to define an alpha channel to make the overlay transparent
				count += 1
				mask = Image.new('RGBA',(width, size_),(0,0,0,255 - index * 10))
				slice_ = Image.composite(img.crop((0, int(height * (sorted_x[index][0] * 0.01)), width, size_ + int(height * (sorted_x[index][0] * 0.01)))),red, mask).convert("RGB")
				slice_.save(str(i) + ".png")
				break
	else:
		if i - previous <= 10:
			mask = Image.new('RGBA',(width, size_),(0,0,0,255 - previous_index * 10 / (i - previous)))
			slice_ = Image.composite(img.crop((0,int(height * (i * 0.01)), width, int(height * (i * 0.01)) + size_)),red, mask).convert("RGB")
			slice_.save(str(i) + ".png")
		else:
			img.crop((0,int(height * (i * 0.01)), width, int(height * (i * 0.01)) + size_)).save(str(i) + ".png")


list_im = []

name = ".png"

for i in xrange(100):
	list_im.append(str(i) + name)

imgs = [ PIL.Image.open(i) for i in list_im ]

# pick the image which is the smallest, and resize the others to match it (can be arbitrary image shape here)
# print sorted( [(np.sum(i.size), i.size ) for i in imgs])
min_shape = sorted( [(np.sum(i.size), i.size ) for i in imgs])[0][1]
imgs_comb = np.hstack( (np.asarray( i.resize(min_shape) ) for i in imgs ) )

# for a vertical stacking it is simple: use vstack
imgs_comb = np.vstack( (np.asarray( i.resize(min_shape) ) for i in imgs ) )
imgs_comb = PIL.Image.fromarray( imgs_comb)
imgs_comb.save("34 Genuinely Funny Tweets About The Oscars Best Picture Shitshow-Margarate.jpg")





