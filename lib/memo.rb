class Memo < Post
  def read_from_console
    puts "Новая заметка(все, что пишем до строчки 'end')"

    line = nil

    while line != "end" do
      line = $stdin.gets.chomp
      @text << line
    end

    @text.pop
  end

  def to_strings
    time_string = "Создано: #{@created_at.strftime("%Y.%m.%d, %H:%M:%S")} \n\r \n\r"

    return @text.unshift(time_string)
  end

  def to_db_hash
    return super.merge(
      {
        text: @text.join("\n\r")
      }
    )
  end

  def load_data(data_hash)
    # Сперва дергаем родительский метод load_data для общих полей. Обратите
    # внимание, что вызов без параметров тут эквивалентен super(data_hash), так
    # как те же параметры будут переданы методу super автоматически.
    super(data_hash)

    # Теперь достаем из хэша специфичное только для задачи значение text
    @text = data_hash['text'].split('\n')
  end
end
