
# Utility to extract secondary unit designator abbreviations from the USPS web page at http://pe.usps.com/text/pub28/28apc_003.htm

# Must be run from the top-level directory of the distribution
# e.g. ruby ./utilities/extract-secondary-unit-designator-abbreviations.rb
# Output: tab-separated list in './references/secondary-unit-designator-abbreviations.tsv'
#
# Dependencies
# 
# Ruby >= 1.9.1
# hpricot >= 0.8.6
#
require 'hpricot'

# ID of HTML table containing abbreviations 
MAIN_TABLE_ELEMENT_ID = 'ep538257'

# File name of HTML content from http://pe.usps.com/text/pub28/28apc_003.htm
SOURCE_FILE_NAME = 'references/USPS-Publication28-SecondaryUnitDesignators.html'

OUTPUT_FILE_NAME = 'references/secondary-unit-designator-abbreviations.tsv'

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
              left_column_values << a.inner_text.strip.chomp
            else
              right_column_value = a.inner_text.strip.chomp.gsub(/\*/,'')
            end
          end
        end
        column = column == :left ? :right : :left
      end
      left_column_values.each do |left_column_value|
        if left_column_value =~ /^Blank/ or left_column_value =~ /^\*/
          next
        end
        output_file.puts %{#{left_column_value}#{OUTPUT_SEPARATOR}#{right_column_value}}
      end
    end
  end

end