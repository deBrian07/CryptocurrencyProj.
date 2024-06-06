function id = Unique_ID(n)
    % OUTPUT: a vector with all the IDs for each node of a graph
    ids = strings(1,n);
    for i = 1:n
        temp =  java.util.UUID.randomUUID;
        myuuid = temp.toString;
        ids(i) = myuuid;
    end
    id = ids;
end