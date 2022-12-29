require 'date'

class Task < Post
  def initialize
    super

    @due_date = Time.now
  end
  def read_from_console
    puts "Что надо сделать?"
    @text = $stdin.gets.chomp

    puts "К какому числу? Укажите дату в формате ДД.ММ.ГГГ"
    input = $stdin.gets.chomp

    @due_date = Date.parse(input)
  end

  def to_strings
    time_string = "Создано: #{@created_at.strftime("%Y.%m.%d, %H:%M:%S")} \n\r \n\r"

    deadline = "Крайний срок: #{@due_date}"

    return [deadline, @text, time_string]
  end

  def to_db_hash
    return super.merge(
      {
        text: @text,
        due_date: @due_date.to_s
      }
    )
  end

  def load_data(data_hash)
    # Сперва дергаем родительский метод load_data для общих полей. Обратите
    # внимание, что вызов без параметров тут эквивалентен super(data_hash), так
    # как те же параметры будут переданы методу super автоматически.
    super

    # Теперь достаем из хэша специфичное только для задачи значение due_date
    @due_date = Date.parse(data_hash['due_date'])
  end
end
