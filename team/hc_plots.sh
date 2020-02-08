#!/bin/bash

# TO DO 
gnuplot -e "set terminal pdf; \
            set title 'average value'; \
            set boxwidth -2; \
            set xrange [0:7]; \
            plot './average-value-data.dat' using 1:3:4:xtic(2) with boxerrorbars;"  > ./average-value-data.pdf
