require 'pry'
namespace :download do
  desc "TODO"
  task refresh: :environment do
    Book.all.each do |book|
      folder = "#{Rails.root}/#{book.title.gsub(/ /, '_')}"

      if File.directory?(folder)
        files = Dir.glob("#{folder}/text/*.md")
        FileUtils.rm_rf(files)
        chapters = book.chapters.order(:chapter_order)
        footnote_number = 1
        chapters.each_with_index do |chapter, index|
          index = index.to_s.rjust(3,"0")
          out_file = File.new("#{folder}/text/#{index}.md", "w")
          out_file.puts(chapter.name)
          out_file.puts("-----------------")
          chapter_body = "#{chapter.body}\n"
          annotations = chapter.annotations.order(:offset)
          annotations.each do |annotation|
            puts footnote_number
            footnote_call = "[^#{footnote_number}][^#{footnote_number}]"
            offset = annotation.offset + annotation.length
            p1 = chapter_body[0, offset -13]
            # int numLines = aDiff.text.Split('\n').Length
            p2 = footnote_call
            p3 = chapter_body[offset -13, chapter_body.length-1]
            chapter_body = p1 + p2 + p3
            chapter_body << ("\n[^#{footnote_number}]: #{annotation.note}")
            footnote_number += 1
          end
          out_file.puts("#{chapter_body}")
          out_file.close
        end
        # exec("cd #{book.title.gsub(/ /, '_')}")
        # exec("kitabu export")# kitabu export
      end

    end
  end
end
