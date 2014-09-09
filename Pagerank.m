function []=Pagerank()

% read in the team indicies and names to a vector of numbers and strings
[team_index, teamnames] = textread('teamname_data.csv','%d,%s');

data = csvread('game_data.csv');

[m,m1] = size(data); % m is the number of games played in the division
[n,n1] = size(teamnames); % n is the number of teams in the division

B = zeros(n,n);
M = zeros(n,n);
r = zeros(n,1);

% generate B
for i=1:m
    difference = data(i,3) - data(i,5);
    if difference >= 0
        B(data(i,2), data(i,4)) = B(data(i,2), data(i,4)) + difference;
    else
        B(data(i,4), data(i,2)) = B(data(i,4), data(i,2)) - difference;
    end
end

% generate M from B
colSum = sum(B,1);
for i=1:n
    for j=1:n
        M(j,i) = B(j,i) / colSum(i);
    end
end

% compute ranking vector, r.
[S,D] = eig(M);
for i=1:n
    r(i) = S(i,1);
end

rSum = abs(sum(r));
for i=1:n
    r(i) = abs(r(i)) / rSum;
end

% sort teams by ranking r. sortedteam_index holds indicies from r
[sorted_r, sortedteam_index]=sort(r,'descend');
for i=1:n
    sorted_teamnames(i)=teamnames(sortedteam_index(i));
end

for i=1:n
    fprintf(1,'%6.3f \t',i, sorted_r(i));
    disp(sorted_teamnames(i))
end
