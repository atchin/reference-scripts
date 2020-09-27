# ggplot2 cheatsheet

ggplot(data, aes(x=, y=, color/fill/=)) # x and y arguments specify the limits, and color/fill/etc. arguments specifies categorical data
# data can be DATAFRAMES or TBLS

qplot(x=,y=,color=,data=) # quickplot

********************************************
#### check out different visualizations at https://www.r-graph-gallery.com/index.html
geom_***() +
  geom_***() # adding other geoms allows you to add on more data, even from different data sources


********************************************
#### Multiple Plots
facet_wrap(~category, nrow/ncol) # plots data by category in different figures

library(cowplot)
plot_grid(p1, p2, labels="AUTO", ncol=, nrow=) # "AUTO" is Capitalized Letter labels, "auto" is decapitalized


********************************************
#### Customization
# themes for plots https://ggplot2.tidyverse.org/reference/ggtheme.html

# ablines
geom_vline(xintercept=, color=, linetype=, size=)
geom_hline(yintercept=, color=, linetype=, size=)


********************************************
#### Plot Labels
# ggplot takes data frames to specify Caartesian coordinates for labels and overplotting points
annotations <- data.frame(x=,
                          y=,
                          annotation=)
geom_text(data=annotations,
          aes(x=x, y=y, label=annotation), inherit.aes=F, # inherit.aes=F means that prior aes() calls are ignored
              size=,)


********************************************
#### Axes Customization
# axes limits
scale_x_continuous(limits=range(data), # sets axis limits and range
                    expand=c(0,0)) # equivalent to xaxs="i" in base

# axes labels
xlab() + ylab() # directly change axes labels
theme(axis.text=element_text(), # size= for text size
      axis.title=element_text(),
      axis.text.y/x=,
      axis.text.y.left/right= # appears when sec.axis is used

)

# special characters: assign unisoce character (\u****) to an object and call in axis label argument
xlabel <- expression(paste(delta^13, "C (\u2030)",sep=""))
xlab(xlabel)
SrCa <- expression(paste("Ba:Ca ratio (\U03BCmol/mol)",sep=""))
scale_y_continuous(name=SrCa)

# adding a second y-axis (NOTE: second axis must scale with first axis)
coeff <- ***
geom_line(aes(y=X86Sr), color="black", linetype="dashed") + # plot first line
geom_line(aes(y=X138Ba*coeff), color="turquoise", linetype="dashed")  + # plot second with scaling factor
scale_y_continuous(name="Sr:Ca ratio (mmol/mol)",
                  sec.axis = sec_axis(trans=~./(coeff*10), #add second axis here
                  name="Ba:Ca (umol/mol)")) +

********************************************
# Legends https://www.r-graph-gallery.com/239-custom-layout-legend-ggplot2.html
# reorder data and legend title
scale_color_discrete(name=, # name of legend plot
                    breaks=c(), # categorical data to be ordered in
                    labels=c() # actual names displayed
                  )
scale_shape_discrete() # does the same thing as the previous
labs(fill=) # specifies the Legend title and variables listed

# legend appearance and formatting
theme(
  legend.text=element_text(size=, color=),
  legend.title=element_text(face="bold")
)

# reposition legend
theme(legend.position=c(0,0)) # drops the legend on the Caartesian grid
