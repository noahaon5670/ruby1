require "csv"

class Memo
  def initialize
    set_memotype
  end
  
  def type_select_message
    puts "1(新規でメモを作成) 2(既存のメモ編集する)"
  end
  
  def ask_the_filename_message
    puts "拡張子を除いたファイル名を記入してください"
  end
  
  def set_memotype
    isLoop = true
    while isLoop
      type_select_message
      @memo_type = gets.to_i
      if @memo_type == 1 or @memo_type == 2 then
        isLoop = false
      end
    end
  end
  
  def edit_message
    puts "メモしたい内容を記入してください"
    puts "完了したらcontrol + dを押してください"
  end
  
  def is_file_exist
    return  File.exist?("#{@file_name}.csv")
  end
  
  def edit_csv(char)
    edit_message
    memo_text = readlines(chomp:true)
    CSV.open("#{@file_name}.csv",char) do |csv|
      csv << memo_text
    end
  end
  
  def create
    if !is_file_exist then
      edit_csv("w")
    else
      puts "ファイル名が重複してます"
    end
  end
  
  def rewrite
    if is_file_exist then
      edit_csv("a")
    else
      puts "ファイル名が存在しません"
    end
  end
  
  def create_and_rewrite
    ask_the_filename_message
    @file_name = gets.to_s.chomp
    case @memo_type
      when 1
        create
      when 2
        rewrite
    end
  end
end

# ------------------------------------------------------------------------------------------------------------------------------------

memo = Memo.new()
memo.create_and_rewrite