#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Nov 22 14:25:52 2019

@author: benlaird
"""
import math

class Calculator:
    def __init__(self, data):
        data.sort()
        self.data = data
        self._reinit()

    def _reinit(self):
        self.length = self._length()
        self.mean = self._calc_mean()
        self.median = self._calc_median()
        self.variance = self._calc_variance()
        self.stand_dev = self._calc_std()

    def _calc_mean(self):
        sum = 0
        for w in self.data:
            sum += w
        mean = sum / len(self.data)
        return mean

    def _calc_median(self):
        if len(self.data) % 2 == 0:
            mid_left = self.data[len(self.data) // 2 - 1]
            mid_right = self.data[len(self.data) // 2]
            avg = (mid_left + mid_right) / 2
        else:
            avg = self.data[len(self.data) // 2]
        return avg

    def _calc_variance(self):
        sum_sqs = 0
        mean = self._calc_mean()
        for d in self.data:
            sum_sqs += (d - mean) ** 2
        return sum_sqs / (len(self.data) - 1)

    def _calc_std(self):
        return self._calc_variance() ** 0.5

    def _length(self):
        return len(self.data)

    def add_data(self, new_data):
        self.data.extend(new_data)
        self.data.sort()
        #update all the mean, variance etc...
        self._reinit()

    def remove_data(self, remove_data):
        # No need to re-sort if data is removed

        # List comprehension - one-liner
        self.data = [x for x in self.data if x not in remove_data]
        '''
        for r in remove_data:
            # throws ValueError if r not in list
            try:
                self.data.remove(r)
            except ValueError:
                pass
        '''
        self._reinit()

    def print_attrs(self):
        #print("Mean is: {mean}, mediam is: {median} variance is: {var} stddev is: {stddev}".
        #     format(mean=self.mean, median=self.median, var=self.variance, stddev=self.stand_dev))
        print(f"Mean is: {self.mean}, mediam is: {self.median} variance is: {self.variance} stddev is: {self.stand_dev}")

c = Calculator([1, 2, 3])
c.print_attrs()

c.remove_data([3])
c.print_attrs()

c.add_data([3])
c.print_attrs()

c.remove_data([4])
c.print_attrs()


