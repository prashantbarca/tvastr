module Tvastr
  # Base
  class Base
    attr_accessor :parse_tree

    # Constructor
    def initialize
      @parse_tree = []
    end

    def self.parser name, &block
      File.open(Tvastr.get_file, 'a') do |file|
        file.write("#{name} = " + Tvastr::Base.new.instance_eval(&block)[0] + "\n")
      end
    end

    # bits
    def bits name, num, bool, *options
      if num.class == Integer && !!bool == bool
        if bool
          boo = "true"
        else
          boo = "false"
        end
        add_options("h.bits(" + num.to_s + ", #{boo}" + ")")
      # Hammer::Parser.bits(num, bool)
      else
        raise TypeError
      end
    end

    # TODO add check for int_type
    def int_range name, int_type, i1, i2, *options
      if i1.class == Integer && i2.class == Integer
        add_options("h.int_range(" + int_type + ',' + i1.to_s + ", " + i2.to_s  + ")")
        # Hammer::Parser.int_range(i1, i2)
      end
    end

    #
    def ch c1, name, *options
      if c1.class != String || c1.length != 1
        raise TypeError
      end
      # Hammer::Parser.ch(c1)
      add_options("h.ch('" + c1  + "')", options)
    end

    #
    def ch_range name, c1, c2, *options

      if name.class != String
        raise TypeError
      end

      if c1.class != String || c1.length != 1
        raise TypeError
      end

      if c2.class != String || c2.length != 1
        raise TypeError
      end

      # Hammer::Parser.ch_range(c1, c2)
      add_options("h.ch_range('" + c1 + "', '" + c2 + "')", options)
    end

    #
    def uint8 name, *options
      # Hammer::Parser.uint8()
      parse_tree.append(add_options("h.uint8()", options))
    end

    #
    def uint16 name, *options
      # Hammer::Parser.uint16()
      parse_tree.append(add_options("h.uint16()", options))
    end

    #
    def uint32 name, *options
      # Hammer::Parser.uint32()
      add_options("h.uint32()", options)
    end

    #
    def uint64 name, *options
      # Hammer::Parser.uint64()
      add_options("h.uint64()", options)
    end

    #
    def int8 name, *options
      # Hammer::Parser.int8()
      add_options("h.int8()", options)
    end

    #
    def int16 name, *options
      # Hammer::Parser.int16()
      add_options("h.int16()", options)
    end

    #
    def int32 name, *options
      # Hammer::Parser.int32()
      add_options("h.int32()", options)
    end

    #
    def int64 name, *options
      # Hammer::Parser.int64()
      add_options("h.int64()", options)
    end

    # Token
    def token name, string, *options
      add_options("h.token(\"" + string + "\", " + string.length.to_s + ")", options)
      # Hammer::Parser.token(string)
    end

    # xor
    def xor name, arg1, arg2, *options
      add_options("h.choice(" + arg1 + ", " + arg2 + ")", options)
    end

    # add options if they were given as args
    def add_options string, options
      options.each do |option|
        if option == 'many'
          string = "h.many(" + string + ")"
        elsif option == 'optional'
          string = "h.optional(" + string + ")"
        elsif option == 'many1'
          string = "h.many1(" + string + ")"
        end 
      end
      string
    end

    #
    def sequence name, *options, &block
      unless block_given? && name.class == String
        raise TypeError
      end
      sequence_input = "h.sequence("
      tmp = Tvastr::Base.new
      tmp.instance_eval(&block)
      for val in tmp.parse_tree
        sequence_input = sequence_input + val + ","
      end
      sequence_input[-1] = ")"
      parse_tree.append(add_options(sequence_input, options))
      parse_tree
    end
  end
end
