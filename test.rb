def display array
    for i in array do
        for j in i do
          if j.to_s.length==2
            print j , '    '
          elsif j.to_s.length==3
            print j , '   '
          else
            print j , '     '
          end
        end
        puts ''
        puts ''
    end    
end
def update_array_of_exp expression,update_val,val,array
    exp_split=expression.split(' = ')
    exp_right_evaluate=0
    exp_left=exp_split[0]
    exp_right=exp_split[1]
    exp_right_split=exp_right.split(' ')
    exp_right_left_operand=exp_right_split[0]
    exp_right_operator=exp_right_split[1]
    exp_right_right_operand=exp_right_split[2]
    if exp_right_operator == '+'
        # puts 'inside update +'
        if exp_right_left_operand.include? val
            # puts 'inside left operand include'
            exp_right_evaluate=update_val+array[exp_right_right_operand[1].to_i+1][H[exp_right_right_operand[0]]]
        else
            # puts 'inside right operand include'
            exp_right_evaluate=array[exp_right_left_operand[1].to_i+1][H[exp_right_left_operand[0]]]+update_val
        end
    elsif exp_right_operator == '-'
        if exp_right_left_operand.include? val
            exp_right_evaluate=update_val-array[exp_right_right_operand[1].to_i+1][H[exp_right_right_operand[0]]]
        else
            exp_right_evaluate=array[exp_right_left_operand[1].to_i+1][H[exp_right_left_operand[0]]]-update_val
        end
    elsif exp_right_operator == '*'
        # puts 'inside update *'
        if exp_right_left_operand.include? val
            # puts 'inside left operand include'
            exp_right_evaluate=update_val*array[exp_right_right_operand[1].to_i+1][H[exp_right_right_operand[0]]]
        else
            # puts 'inside right operand include'
            exp_right_evaluate=array[exp_right_left_operand[1].to_i+1][H[exp_right_left_operand[0]]]*update_val
        end
    elsif exp_right_operator == '/'
        if exp_right_left_operand.include? val
            exp_right_evaluate=update_val/array[exp_right_right_operand[1].to_i+1][H[exp_right_right_operand[0]]]
        else
            exp_right_evaluate=array[exp_right_left_operand[1].to_i+1][H[exp_right_left_operand[0]]]/update_val
        end
    end
return exp_right_evaluate
end

array=[['-','A','B','C','D','E','F','G','H','I','J']]
for i in 0..9 do
    array.push Array.new(11,0)
    array[i+1][0]=i
end
H = Hash["A" => 1, "B" => 2, "C" => 3, "D" => 4, "E" => 5, "F" => 6, "G" => 7, "H" => 8, "I" => 9, "J" => 10]
exp_array=Array.new()
puts 'Intial Board is:'
display(array)
puts 'Action List:'
puts '1) Set Value'
puts '2) Set Expression'
puts '3) Exit'
puts 'Enter your action choice:'
choice = gets.chomp
until choice == '3' do
    case choice
  
        when "1"  
          puts 'Enter set value command'
          value = gets.chomp
          a1=value.split(' = ')
          rc=a1[0].split('')
          row=rc[1].to_i+1
          col=H[rc[0]]
          array[row][col]=a1[1].to_i
          if exp_array.length > 0
            val=a1[0] 
            update_val=a1[1].to_i
            for i in exp_array
                if i.split(' ').include? val
                    # puts i
                    result=update_array_of_exp(i,update_val,val,array)
                    array[i.split(' = ')[0][1].to_i+1][H[i.split(' = ')[0][0]]]=result
                    value = i.split(' = ')[0] + " = " + result.to_s
                    # puts value
                    a1=value.split(' = ')
                    val=a1[0] 
                    update_val=a1[1].to_i
                end
            end
          end
          puts 'Set Value Command applied, your new board is:'
          display(array)
          puts 'Action List:'
          puts '1) Set Value'
          puts '2) Set Expression'
          puts '3) Exit'
          puts 'Enter your action choice:'
          choice= gets.chomp
        when "2"  
          puts 'Enter Set Expression command:'
          exp=gets.chomp
          exp_array.push exp
          exp_split=exp.split(' = ')
          exp_left=exp_split[0]
          exp_right=exp_split[1]
          exp_right_split=exp_right.split(' ')
          exp_right_left_operand=exp_right_split[0]
          exp_right_operator=exp_right_split[1]
          exp_right_right_operand=exp_right_split[2]
          if exp_right_operator == '+'
            exp_right_evaluate=array[exp_right_left_operand[1].to_i+1][H[exp_right_left_operand[0]]]+array[exp_right_right_operand[1].to_i+1][H[exp_right_right_operand[0]]]
          elsif exp_right_operator == '-'
            exp_right_evaluate=array[exp_right_left_operand[1].to_i+1][H[exp_right_left_operand[0]]]-array[exp_right_right_operand[1].to_i+1][H[exp_right_right_operand[0]]]
          elsif exp_right_operator == '*'
            exp_right_evaluate=array[exp_right_left_operand[1].to_i+1][H[exp_right_left_operand[0]]]*array[exp_right_right_operand[1].to_i+1][H[exp_right_right_operand[0]]]
          elsif exp_right_operator == '/'
            exp_right_evaluate=array[exp_right_left_operand[1].to_i+1][H[exp_right_left_operand[0]]]/array[exp_right_right_operand[1].to_i+1][H[exp_right_right_operand[0]]]
          end
          array[exp_left[1].to_i+1][H[exp_left[0]]]=exp_right_evaluate
          puts 'Set Expression Command applied, your new board is '

          display(array)
          puts 'Action List:'
          puts '1) Set Value'
          puts '2) Set Expression'
          puts '3) Exit'
          puts 'Enter your action choice:'
          choice= gets.chomp
          
        when "3"  
          break
          
    else  
      puts "No input like that"
      break

    end
end
puts 'Exited......'