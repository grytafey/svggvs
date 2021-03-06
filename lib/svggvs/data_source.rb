require 'roo'

module SVGGVS
  class DataSource
    def initialize(file, options = {})
      @file, @options = [ file, options ].flatten.compact
    end

    def doc
      @doc ||= Roo::Spreadsheet.open(@file, @options)
    end

    def settings
      settings = {}

      sheets.each do |name, sheet|
        if name['SVGGVS Settings']
          sheet.each do |setting, value|
            settings[setting.spunderscore.to_sym] = value
          end
        end
      end

      settings
    end

    def sheets
      return @sheets if @sheets

      @sheets = []

      doc.each_with_pagename do |name, sheet|
        @sheets << [ name, sheet.dup ]
      end

      @sheets
    end

    def each_card(card_sheet_identifier)
      sheets.each do |name, sheet|
        if name[card_sheet_identifier]
          headers = sheet.row(1)

          (sheet.first_row + 1).upto(sheet.last_row) do |index|
            card_data = {
              :active_layers => [],
              :replacements => {}
            }

            headers.zip(sheet.row(index)).each do |header, cell|
              if header['Active Layer']
                card_data[:active_layers] += cell.split(';')
              else
                card_data[:replacements][header] = cell
              end
            end

            yield card_data
          end
        end
      end
    end
  end
end

