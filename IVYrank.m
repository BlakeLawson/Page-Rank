function []=IVYrank()

% read in the team indices and names to a vector of numbers and strings
[team_index,teamnames]=textread('teamname_data.csv','%d,%s');

data=csvread('game_data.csv');

[m,m1]=size(data); % m is the number of games played in the division
[n,n1]=size(teamnames); % n is the number of teams in the division

r=zeros(n,1);   % initialize IVY ranking


for k=1:m
    team1=data(k,2);
    team2=data(k,4);
    team1_score=data(k,3);
    team2_score=data(k,5);
    if team1_score>team2_score
        r(team1)=r(team1)+1;
        r(team2)=r(team2)-1;
    else
        r(team1)=r(team1)-1;    % update winning/losing record
        r(team2)=r(team2)+1;
    end
end

r=(r-max(r)*ones(n,1))/2;       % adopt IVY ranking scheme
   
% sort teams by ranking r. sortedteam_index holds indices from r
[sorted_r, sortedteam_index]=sort(r,'descend');
for i=1:n
    sorted_teamnames(i)=teamnames(sortedteam_index(i));
end

for i=1:n
    fprintf(1,'%6.3f \t',i, sorted_r(i)); 
    disp(sorted_teamnames(i))
end