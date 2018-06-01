% http://pythonforengineers.com/machine-learning-for-complete-beginners/
% https://machinelearningmastery.com/implement-decision-tree-algorithm-scratch-python/

clear ; close all; clc

% _,row.names,pclass,survived,name,age,embarked,home.dest,room,ticket,boat,sex
test_csv = csv2cell('titanic_test.csv','fromfile');
train_csv = csv2cell('titanic_train.csv','fromfile');

% pclass,age,sex
headers = [test_csv(1,4) test_csv(1,3) test_csv(1,6) test_csv(1,12)];

survive_test = str2num(cell2mat(test_csv(2:end,4)));
survive_train = str2num(cell2mat(train_csv(2:end,4)));

test_data = [test_csv(2:end,3) test_csv(2:end,6) test_csv(2:end,12)];
train_data = [train_csv(2:end,3) train_csv(2:end,6) train_csv(2:end,12)];

check = processData(test_data);
train = processData(train_data);

% Produce csv file to  run ID3 decision tree
fid = fopen('tree.csv', 'w');
for i = 1:(length(headers)-1)
  fprintf(fid, '%s,', char(headers(i)));
end
fprintf(fid, '%s\n', char(headers(4))) ;

dlmwrite('tree.csv', [survive_train train], '-append') ;

fclose(fid) ;

% M5 model tree
params = m5pparams2('modelTree', true);
model = m5pbuild(train, survive_train, params, [true true true]);

% Predictions
predicts = zeros(length(survive_test),1);
for i = 1:length(survive_test)
  predicts(i) = m5ppredict(model, check(i,:)) >= 0.5;
end

score = 1 - sum(xor(predicts,survive_test))/length(survive_test)
