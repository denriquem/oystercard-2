class Journey

  attr_reader :entry_station, :exit_station

def start(entry_station)
  @entry_station = entry_station
end

def finish(exit_station)
  @exit_station = exit_station
end

def in_journey?
 if @entry_station != nil && @exit_station == nil
   return true

 elsif @exit_station != nil && @entry_station != nil
   return false
 end
 
end

def fare
  if in_journey?
    return 3
  else
    return 6
  end

end




end
