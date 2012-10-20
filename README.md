# address_normalizer #

(c) 2012 Tracy Flynn
address_normalizer may be freely distributed under the MIT license.

Version 0.0.1

## Description ##

address_normalizer is a library that standardizes US Postal Addresses, and individual and business names.

## Prerequisites ##

### Ruby environment ###

* Ruby 1.9 (>= 1.9.1)
* hpricot (>0.8.6)

## Tools ##

### extract-business-abbreviations.rb ###

Extract business abbreviations from the [USPS page of business abbreviations](http://pe.usps.com/text/pub28/28apg.htm).

#### To run ####

ruby ./utilities/extract-business-abbreviations.rb 

#### Output ####

Tab-separated list

* First element: Common presentation
* Second element: USPS Standard abbreviation



