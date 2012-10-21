
# Utility to extract business abbreviations from the USPS web page at http://pe.usps.com/text/pub28/28apg.htm

# Must be run from the top-level directory of the distribution
# e.g. ruby ./utilities/extract-business-abbreviations.rb
# Output: tab-separated list in './references/business-abbreviations.tsv'
#
# Dependencies
# 
# Ruby >= 1.9.1
# hpricot >= 0.8.6
#
require 'hpricot'

# ID of HTML table containing abbreviations 
MAIN_TABLE_ELEMENT_ID = 'ep574329'

# File name of HTML content from http://pe.usps.com/text/pub28/28apg.htm
SOURCE_FILE_NAME = 'references/USPS-Publication28-StandardBusinessAbbreviations.html'

OUTPUT_FILE_NAME = 'references/business-abbreviations.tsv'

OUTPUT_SEPARATOR = "\t"

open(OUTPUT_FILE_NAME,'w') do |output_file|
  
  open(SOURCE_FILE_NAME) do |source_doc|
  
    doc = Hpricot(source_doc)
    
    table_el = (doc/"##{MAIN_TABLE_ELEMENT_ID}")
    first_tr = true
    column = :left
    (table_el/"tr").each do |tr|
      if first_tr
        first_tr = false
        next
      end
      left_column_values = []
      right_column_value = nil
      (tr/"td").each do |td|
        (td/"p").each do |p|
          (p/"a").each do |a|
            if column == :left
              left_column_values << a.inner_html
            else
              right_column_value = a.inner_html
            end
          end
        end
        column = column == :left ? :right : :left
      end
      left_column_values.each do |left_column_value|
        output_file.puts %{#{left_column_value}#{OUTPUT_SEPARATOR}#{right_column_value}}
      end
    end
  end

end