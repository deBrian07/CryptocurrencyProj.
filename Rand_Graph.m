function RG = Rand_Graph(n, p)
% similar with ER Graph, but a directed graph
% OUTPUT: a adjacency matrix of a graph
    A = zeros(n);
    for i = 1:n
        for j = 1:n
            R = rand();
            if R < p
                A(i,j) = 1;
            end
        end
    end
    RG = A;
end