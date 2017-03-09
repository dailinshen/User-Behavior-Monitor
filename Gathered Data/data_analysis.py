import glob
import shutil
import os
import google
import csv

path = "/Users/lindashen/Desktop/Gathered Data/"

path_lists = ["Dailin Shen","Houliang Lv","Tanya", "Xiaoqian Ma", "Huixin Deng", "Margarate Qian"]

title_set = set()

write_file = open("dict.csv", "wb")
write_ = csv.writer(write_file)

for p in path_lists:
    for txtfile in glob.iglob(path + p + "/*.txt"):
    # for txtfile in glob.iglob(path + p + "/*"):
        # Used to add an extension and delete the original file
        # shutil.copy2(txtfile, " ".join(txtfile.split("_"))+".txt")
        # os.remove(txtfile)

        # Create title_set in order to be used in search
        # title = txtfile.rsplit("/")[-1]
        # title = title[:(len(title))]
        # if title not in title_set:
        #     title_set.add(title)
        #     print title
        #     # print type(title)
        #     # write_.writerow([title])
        #     for i in google.search(title, stop=2):
        #         print i

# print title_set
