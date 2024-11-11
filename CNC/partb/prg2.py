2.Write a program for distance vector algorithm to find suitable
path for transmission.


n = int(input("Enter number of nodes : "))
print("Enter the cost matrix : ")
cost_matrix = [list(map(int, input().split())) for _ in range(n)]
rt = [[float('inf')] * (n + 1) for _ in range(n + 1)]
for i in range(1, n + 1):
rt[i][i] = 0
for _ in range(n - 1):
for i in range(1, n + 1):
for j in range(1, n + 1):
for k in range(1, n + 1):
rt[i][j] = min(rt[i][j], rt[i][k] + cost_matrix[k-1][j-1])
for i in range(1, n + 1):
print(f"\nRouter {chr(i + 64)}:" + "".join(f"\n\tNode {j} Distance:
{rt[i][j]}" for j in range(1, n + 1)))
