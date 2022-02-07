import tkinter as Tk

from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from matplotlib.figure import Figure

import networkx as nx

#LENDO UM ARQUIVO
import pandas as pd
df = pd.read_csv("network_lista.csv")

import matplotlib.pyplot as plt


class Model():

    def __init__(self):
        self.xpoint = 200
        self.ypoint = 200
        self.res = None



class View():
    def __init__(self, master):
        self.frame = Tk.Frame(master)
        self.fig = Figure(figsize=(7.5, 4), dpi=80)
        self.ax0 = self.fig.add_axes(
            (0.05, .05, .90, .90), facecolor=(.75, .75, .75), frameon=False)
        self.frame.pack(side=Tk.RIGHT, fill=Tk.BOTH, expand=1)
        self.sidepanel = SidePanel(master)
        self.canvas = FigureCanvasTkAgg(self.fig, master=self.frame)
        self.canvas.get_tk_widget().pack(side=Tk.TOP, fill=Tk.BOTH, expand=1)
        self.canvas.draw()


class SidePanel():
    def __init__(self, root):
        self.frame2 = Tk.Frame(root)
        self.frame2.pack(side=Tk.LEFT, fill=Tk.BOTH, expand=1)
        self.plotBut = Tk.Button(self.frame2, text="Plotar ")
        self.plotBut.pack(side="top", fill=Tk.BOTH)
        self.clearButton = Tk.Button(self.frame2, text="Limpar")
        self.clearButton.pack(side="top", fill=Tk.BOTH)


class Controller():
    def __init__(self):
        self.root = Tk.Tk()
        self.model = Model()
        self.view = View(self.root)
        self.view.sidepanel.plotBut.bind("<Button>", self.my_plot)
        self.view.sidepanel.clearButton.bind("<Button>", self.clear)

    def run(self):
        self.root.title("Network")
        self.root.deiconify()
        self.root.mainloop()

    def clear(self, event):
        self.view.ax0.clear()
        self.view.fig.canvas.draw()

    def my_plot(self, event):
        df.head()

        greys = nx.from_pandas_edgelist(df, source="from", target="to")
        greys
        nx.info(greys)

        # Verificar todos os nós
        greys.nodes
        greys.edges

        #####
        f = plt.figure(figsize=(20, 20))

        nx.draw_networkx(greys)
        canvas = FigureCanvasTkAgg(f)
        canvas.get_tk_widget().pack(side='bottom', fill='both', expand=1)  # ERROR Tk.
        #####

        nx.draw_networkx(greys)

if __name__ == '__main__':
    c = Controller()
    c.run()