function p = parzen_win(u)
if norm(u) < 0.5
    p = 1;
else 
    p = 0; 
end
end