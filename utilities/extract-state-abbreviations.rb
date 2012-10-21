
# Utility to extract state abbreviations from the USPS web page at http://pe.usps.com/text/pub28/28apb.htm

# Must be run from the top-level directory of the distribution
# e.g. ruby ./utilities/extract_state_abbreviations.rb > [output-file]

# Dependencies
# 
# Ruby >= 1.9.1
# hpricot >= 0.8.6
#
require 'hpricot'

# ID of HTML table containing abbreviations 
MAIN_TABLE_ELEMENT_ID = 'ep574329'

# File name of HTML content from http://pe.usps.com/text/pub28/28apg.htm
SOURCE_FILE_NAME = 'references/USPS-Publication28-StateAbbreviations.html'

ABBREVIATIONS_OUTPUT_FILE_NAME = 'references/state-abbreviations.tsv'
GEOGRAPHIC_DIRECTIONALS_OUTPUT_FILE_NAME = 'references/geographic-directionals-abbreviations.tsv'
MILITARY_STATES_OUTPUT_FILE_NAME = 'references/military-states-abbreviations.tsv'

OUTPUT_SEPARATOR = "\t"

open(SOURCE_FILE_NAME) do |source_doc|
  
  doc = Hpricot(source_doc)
  
  # Process main table
  table_el = (doc/"#ep18684")
  first_tr = true
  column = :left
  abbreviations_list = []
  (table_el/"tr").each do |tr|
    if first_tr
      first_tr = false
      next
    end
    left_column_value = nil
    right_column_value = nil
    (tr/"td").each do |td|
      (td/"p").each do |p|
        (p/"a").each do |a|
          if column == :left
            left_column_value = a.inner_html
          else
            right_column_value = a.inner_html
          end
        end
      end
      column = column == :left ? :right : :left
    end
    abbreviations_list << [left_column_value,right_column_value]
  end
  open(ABBREVIATIONS_OUTPUT_FILE_NAME,'w') do |output_file|
    abbreviations_list.each do |abbreviation_pair|
      output_file.puts %{#{abbreviation_pair[0]}#{OUTPUT_SEPARATOR}#{abbreviation_pair[1]}}
    end
  end

  # Process geographic directionals tables
  table_el = (doc/"#ep19168")
  first_tr = true
  column = :left
  abbreviations_list = []
  (table_el/"tr").each do |tr|
    if first_tr
      first_tr = false
      next
    end
    left_column_value = nil
    right_column_value = nil
    (tr/"td").each do |td|
      (td/"p").each do |p|
        (p/"a").each do |a|
          if column == :left
            left_column_value = a.inner_html
          else
            right_column_value = a.inner_html
          end
        end
      end
      column = column == :left ? :right : :left
    end
    abbreviations_list << [left_column_value,right_column_value]
  end
  open(GEOGRAPHIC_DIRECTIONALS_OUTPUT_FILE_NAME,'w') do |output_file|
    abbreviations_list.each do |abbreviation_pair|
      output_file.puts %{#{abbreviation_pair[0]}#{OUTPUT_SEPARATOR}#{abbreviation_pair[1]}}
    end
  end

  # Process military states tables
  table_el = (doc/"#ep19241")
  first_tr = true
  column = :left
  abbreviations_list = []
  (table_el/"tr").each do |tr|
    if first_tr
      first_tr = false
      next
    end
    left_column_value = nil
    right_column_value = nil
    (tr/"td").each do |td|
      (td/"p").each do |p|
        (p/"a").each do |a|
          if column == :left
            left_column_value = a.inner_text
          else
            right_column_value = a.inner_text
          end
        end
      end
      column = column == :left ? :right : :left
    end
    abbreviations_list << [left_column_value,right_column_value]
  end
  open(MILITARY_STATES_OUTPUT_FILE_NAME,'w') do |output_file|
    abbreviations_list.each do |abbreviation_pair|
      output_file.puts %{#{abbreviation_pair[0]}#{OUTPUT_SEPARATOR}#{abbreviation_pair[1]}}
    end
  end
  
end