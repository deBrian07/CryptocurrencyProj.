function B = wallet_balance(G1, v, balance1)
    % G1 as the network as a GRAPH
    % v as the vertex
    % balance as the balance of the vertex v
    % OUTPUT: the balance for vertex i
    [out_e, receivers] = outedges(G1,v); % find the out edges
    [in_e, senders] = inedges(G1, v); % find the in edges
    % Reciever and senders are two vectors that stores the nodes of in &
    % out edges
    
    % minus all the outgoing transactions
    for i = 1:length(out_e)
        balance1 = balance1 - G1.Edges.Weight(findedge(G1,v,receivers(i)));
    end

    % adding all the incoming transactions
    for i = 1:length(in_e)
        balance1 = balance1 + G1.Edges.Weight(findedge(G1, senders(i), v));
    end
    B = balance1;
end