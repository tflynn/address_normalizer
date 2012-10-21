
# Utility to extract street suffix abbreviations from the USPS web page at http://pe.usps.com/text/pub28/28apc_002.htm

# Must be run from the top-level directory of the distribution
# e.g. ruby ./utilities/extract-street-suffix-abbreviations.rb
# Output: tab-separated list in './references/bstreet-suffix-abbreviations.tsv'

# Dependencies
# 
# Ruby >= 1.9.1
# hpricot >= 0.8.6
#
require 'hpricot'

# File name of HTML content from http://pe.usps.com/text/pub28/28apc_002.htm
SOURCE_FILE_NAME = 'references/USPS-Publication28-StreetSuffixAbbreviations.html'

ABBREVIATIONS_OUTPUT_FILE_NAME = 'references/street-suffix-abbreviations.tsv'

OUTPUT_SEPARATOR = "\t"

street_abbreviations = []

open(SOURCE_FILE_NAME) do |source_doc|

  doc = Hpricot(source_doc)
  
  table_el = (doc/"#ep533076")
  
  # scope
  standard_suffix = nil
  common_suffix = nil
  
  main_header_tr = true
  (table_el/"tr").each do |tr|
    if main_header_tr
      main_header_tr = false
      next
    end
    child_td_elements = (tr/"td")
    total_immediate_children = child_td_elements.size
    if total_immediate_children == 3
      tr_type = :section_header
    else
      tr_type = :standard_section
    end
    #puts "total_immediate_children #{total_immediate_children} tr_type #{tr_type.inspect}"
    #puts child_td_elements.inspect
    
    if tr_type == :section_header
      standard_suffix = nil
      common_suffix = nil
      column = :left
      first_td = true
      (tr/"td").each do |td|
        if first_td 
          first_td = false
          next
        end
        (td/"p").each do |p|
          (p/"a").each do |a|
            if column == :left
              common_suffix = (a.inner_text).strip.chomp
            else
              standard_suffix = (a.inner_text).strip.chomp
            end
          end
        end
        column = column == :left ? :right : :left
      end
      street_abbreviations << [common_suffix, standard_suffix]
    elsif tr_type == :standard_section
      (tr/"td").each do |td|
        (td/"p").each do |p|
          (p/"a").each do |a|
            common_suffix = (a.inner_text).strip.chomp
            street_abbreviations << [common_suffix, standard_suffix]
          end
        end
      end
    end
  end
end

open(ABBREVIATIONS_OUTPUT_FILE_NAME,'w') do |output_file|
  
  street_abbreviations.each do |street_abbreviation|
    output_file.puts %{#{street_abbreviation[0]}#{OUTPUT_SEPARATOR}#{street_abbreviation[1]}}
  end

end