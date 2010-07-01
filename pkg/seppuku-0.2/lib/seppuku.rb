require 'rubygems'
require 'optparse'
require 'open3'

REGEXP = /^(\d+)\s+(.*?)$/
PS = 'ps ax -o pid -o command'

class Seppuku
  class<<self
    
    def run
      ready
      draw! 
    end

    def search
      @search ||= Regexp.new(@opts[:name])
    end

    def command
      Proc.new do |cmd|
        Open3.popen3(cmd) do |si,so,se| 
          stderr = se.readlines
          raise stderr.join('.') unless stderr.empty? 
          so.readlines 
        end
      end
    end

    def matches
      matches=[]
      command.call(PS).each do |line|
        if line =~ search 
          if line !~ /#{$0}/
            matches << line.scan(REGEXP).flatten.map {|m| m.strip }
          end
        end
      end
      matches.delete_if{|m| m.empty?}
    end

    def draw!
      disengage if matches.empty?
      dots  = "."*23
      hding = "#{dots}\n#{matches.size} matches were found!\n"
      puts matches.map {|m| match(m) }.push(hding)
      kill_all_or_wisely      
    end

    def kill_all(matches)
      matches.each { |m| kill(m) }
    end 

    def kill_wisely(matches)
      matches.each do |m|
        kill_ques(m.last)
        ans = gets
        proceed.call(ans) ? kill(m) : next
      end
    end

    def kill_all_or_wisely
      if matches.size > 1
        kill_ques('*ALL*')
        ans = gets
        proceed.call(ans) ? kill_all(matches) : kill_wisely(matches)
      else
        kill_wisely(matches)
      end
    end
    
    def disengage
      puts '<-> nothing to kill <->'
      exit
    end

    def kill(m)
      begin
        pid = m.first
        cmd = "kill -#{@opts[:level]} #{pid}"
        command.call(cmd)
        puts "<.> killed:#{pid} <.>" 
        
      rescue Exception => msg
        puts "#{msg} #{msg.backtrace.join(' ')}"
      end
    end

    def proceed
      Proc.new { |ans| true if ans =~ /y/i }
    end

    def match(m)
      "> #{m.join(' : ')}"
    end

    def kill_ques(type)
      puts "> (y/n) ? kill -#{@opts[:level]} [#{type}]"
    end

    def ready
      @opts={}
      options = OptionParser.new do |op|
        op.on('-n','--name NAME',"Process name within ps table") { |n| @opts[:name] = n }
        op.on('-l','--level LEVEL',"Kill level for operation")  { |l| @opts[:level] = l }
        op.on('-h', '--help', 'Show this screen') { puts options; exit }
      end 
      parse(options)
    end
    
    def parse(options)
      options.parse!
      if @opts[:level].nil? || @opts[:name].nil?
        puts options
        raise OptionParser::MissingArgument  
      end            
    end

  end
end



