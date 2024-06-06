% This program will simulate the cryptocurrency transactions in a real
% network, and output a network and its Blockchain
% -----------------------------------------------------------------------

n = 100; % 100 nodes in this network

A = Rand_Graph(n, 0.05); % creating an adjacency matrix of random directed graph
G = digraph(A);
num_tran = numnodes(G); % number of transactions
amount = zeros(1,num_tran); % the amount of all the transactions 
balance_w = zeros(1, n); % balance of wallets
num_edges = numedges(G);


% amount of transactions as weighted graph
for i = 1:numedges(G)
    amount(i) = randi(50,1); % transaction amount from 1 to 50
end
amount = amount(:);
G.Edges.Weight = amount;

% generating wallet balance 
balance_w = balance_w + 100; % each wallet is assumed to have 100 coins
for i = abs(1:1:n)
    balance_w(i) = wallet_balance(G, i, balance_w(i));
end

% removing nodes with negative balance
for i = n:-1:1
    if balance_w(i) < 0
        G = rmnode(G, i);
        balance_w(i) = [];
    end
end

G1 = G;
n = numnodes(G1);

G = plot(G, 'EdgeLabel', G.Edges.Weight, 'EdgeLabelColor', 'Red', 'NodeFontSize', 10); % GraphPlot of G
% RED: amount, BLACK: Node number
% G is a GraphPlot, but G1 is still a digraph

% generating IDs for each wallet (node)
Wallet_ID = Unique_ID(n); % using UUID to generate random ID for each wallet

% adding Ids to the data tip
row = dataTipTextRow('ID',Wallet_ID);
G.DataTipTemplate.DataTipRows(end+1) = row;

% adding wallet balance to the DATA TIP
row = dataTipTextRow('balance', balance_w);
G.DataTipTemplate.DataTipRows(end+1) = row;

% Blockchain of the network
num_edges = numedges(G1);
senders = strings(num_edges, 1);
receivers = strings(num_edges, 1);
amount = G1.Edges.Weight;
for i = 1:num_edges
    s = G1.Edges.EndNodes(i, 1); % accesing the first column of EndNodes
    senders(i) = Wallet_ID(s); 
    r = G1.Edges.EndNodes(i, 2); % accesing the second column of EndNodes
    receivers(i) = Wallet_ID(r);
end
blockchain = [senders, receivers, amount];  % a cell matrix with sender, reciever, and amount
