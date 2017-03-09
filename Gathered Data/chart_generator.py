import plotly.plotly as py
import plotly.graph_objs as go
import glob
import csv

py.sign_in('dailinshen', 'ueu6aInyihYyotviKwTG') # Replace the username, and API key with your credentials.

path = "/Users/lindashen/Desktop/Gathered Data/"

path_lists = ["Dailin Shen","Houliang Lv","Tanya", "Xiaoqian Ma", "Huixin Deng", "Margarate Qian"]

def graph_generator(x_value, y_value, file_name, path):
	trace = go.Scatter(
	    x = x_value,
	    y = y_value
	)
	data = [trace]

	layout = go.Layout(title=file_name, width=800, height=640)
	fig = go.Figure(data=data, layout=layout)

	py.image.save_as(fig, filename=p + "_" + file_name + '.png')


for p in path_lists:
    for txtfile in glob.iglob(path + p + "/*.txt"):
    	file = open(txtfile, "r")
    	count = 0
    	time_list = []
    	percentage_list = []
    	for line in file:
    		count += 1
    		if count is 1:
    			continue
    		tt = line.split(",")
    		percentage_list.append(float(tt[1].split("\\")[0]))
    		time_list.append(int(tt[0]))
    	filename = txtfile.rsplit("/")[-1].replace(".txt", "")

    	graph_generator(time_list, percentage_list, filename, p)

print "done"
