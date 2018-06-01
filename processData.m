function processed = processData(data)
  
  sum = 0;
  count = 0;
  
  for i = 1:length(data)
    if !cellfun(@isempty,data(i,2))
      sum += str2num(cell2mat(data(i,2)));
      count++;
    endif
  end
  
  average = num2str(sum/count);
  
  for i = 1:length(data)
    if strcmp(data(i,1), '1st')
      data(i,1) = 1;
    elseif strcmp(data(i,1), '2nd')
      data(i,1) = 2;
    elseif strcmp(data(i,1), '3rd')
      data(i,1) = 3;
    endif

    % Median is 29
    if cellfun(@isempty,data(i,2))
      data(i,2) = "29.0";
    endif
  
    if strcmp(data(i,3), 'male')
      data(i,3) = 1;
    elseif strcmp(data(i,3), 'female')
      data(i,3) = 0;
    endif
  end

  process_2 = zeros(length(data),1);

  for i = 1:length(data)
    process_2(i) = idivide(str2num(cell2mat(data(i,2))), 10, "fix");
    % process_2(i) = str2num(cell2mat(data(i,2)));
  end

  processed = [cell2mat(data(:,1)) process_2 cell2mat(data(:,3))];

endfunction