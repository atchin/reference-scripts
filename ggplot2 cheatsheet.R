# ggplot2 cheatsheet
# Remember we must always be thinking about a viewer who will not see the data!

ggplot(data, # this inital call specifies the data range to be used in the plot
  aes(x=, y=, # x and y arguments specify the axes,
  color/fill/lty=)) + # and arguments specifies categorical data; for plotting multiple categories
# data can be DATAFRAMES or TIBBLES (which are dataframes specifically for tidyverse)

ggplot(data, aes(x=,y=, col=group_var1, lty=group_var2))

qplot(x=,y=,color=,data=) # quickplot

********************************************
#### check out different visualizations at https://www.r-graph-gallery.com/index.html
geom_***() +
  geom_***() # adding other geoms allows you to add on more data, even from different data sources

data %>%
    ggplot(aes(x = variable_1)) +
    geom_line(aes(y = variable_2)) +
    geom_line(aes(y = variable_3))

# common geoms
geom_line() # line plot
geom_col() # barplot
geom_point() # scatterplot
geom_bar() # give row counts, useful for data exploration; no need to specify y-axis in aes()
geom_hbar() # horizontal-bar; error bars
geom_histogram( # histogram; no need to specify y-axis in aes()
  binwidth=, bins=) # binwidth = size of bins; bins = number of bins
geom_density() # smoothed out histogram for high resolution data
geom_boxplot() # boxplots

example_bar <- ggplot(data, aes(x, y, fill=group_var1)) + geom_col()
example_line <- ggplot(data, aes(x, y, col=group_var1)) + geom_line() + geom_point() # connected scatterplot

# error bars https://www.r-graph-gallery.com/4-barplot-with-error-bar.html

# pivot data to plot scaled data from multiple columns easier
longdata <- data %>% pivot_longer(cols=c(), names_to='cols', values_to='values')
ggplot(data=longdata, aes(x=Year, y=values, color='cols')) + geom_line()


********************************************
#### Multiple Plots
facet_wrap(~category, nrow/ncol, # plots data by category in different figures
  scales='free'/'free_y'/'free_x' # draw plot with free scaling for each group
  )
facet_wrap(vars(var1, var2))

# multiple plots in a grid from one grouping variable
facet_grid(rows=vars(group_var1),
           cols=vars(group_var2))


library(cowplot)
plot_grid(p1, p2, labels="AUTO", ncol=, nrow=) # "AUTO" is Capitalized Letter labels, "auto" is decapitalized


********************************************
#### Customization
# themes for plots https://ggplot2.tidyverse.org/reference/ggtheme.html

# changing line/point type style
scale_linetype_manual(values=c(1,4))
scale_color_manual(values=c("blue","green"))

# ablines
geom_vline(xintercept=, color=, linetype=, size=)
geom_hline(yintercept=, color=, linetype=, size=)

# hodgehodge of theme() calls
theme(panel.background = element_rect(fill="background_color"), # fill background color with element rectangle
    )


********************************************
#### Axes Customization
# axes limits
scale_x_continuous(limits=range(data) OR c(0,100), # sets axis limits and range
                    expand=c(0,0)) # equivalent to xaxs="i" in base
scale_y_log10() # log10 scale on y-axis

# axes labels
labs(x=, y=, title=)


xlab() + ylab() # directly change axes labels
theme(axis.text=element_text(), # size= for text size
      axis.title=element_text(),
      axis.text.y/x=,
      axis.text.y.left/right= # appears when sec.axis is used
)

# sorting factor data on axis
data <- data %>%
  mutate(cate2_reordered = factor(cate2, levels = c("factor3", "factor2", "factor4", "factor1")))
ggplot(reviews, aes(x=cate2_reordered, y=cate5)) +
  geom_boxplot()

# special characters: assign unicode character (\u****) to an object and call in axis label argument
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
#### Plot Labels
# ggplot takes data frames to specify Caartesian coordinates for labels and overplotting points
annotations <- data.frame(x=,
                          y=,
                          annotation=)
geom_text(data=annotations,
          aes(x=x, y=y, label=annotation), inherit.aes=F, # inherit.aes=F means that prior aes() calls are ignored
          size=,)

********************************************
# Legends https://www.r-graph-gallery.com/239-custom-layout-legend-ggplot2.html
# reordering things, and other lenged customization features: https://www.datanovia.com/en/blog/ggplot-legend-title-position-and-labels/
# reorder data and legend title
scale_color_manual(name=, # name of legend plot
                    breaks=c(), # categorical data to be ordered in; not needed with long-pivoted data
                    labels=c() # actual names displayed
                    values=c()) # for colors

scale_shape_discrete() # does the same thing as the previous
# if you have multiple geoms_ then you need to repeat the names/breaks/labels

labs(fill=) # specifies the Legend title and variables listed

# Reverse legend order. The easy way to reverse the order of legend items is to use the ggplot2 legend guides() function. It change the legend order for the specified aesthetic (fill, color, linetype, shape, size, etc). Example of R code: p + guides(fill = guide_legend(reverse = TRUE)) for color of area fills (e.g.: box plot and bar graph) or p + guides(color = guide_legend(reverse = TRUE)) for point and line color (e.g.: scatter plot and line plot).

# legend appearance and formatting
theme(
  legend.text=element_text(size=, color=),
  legend.title=element_text(face="bold")
)

# reposition legend
theme(legend.position=c(0,0)) # drops the legend on the Caartesian grid
