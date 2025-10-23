# 一 
### 题目：
设随机变量 $X$ 服从标准正态分布 $N(0, 1)$，对给定的 $\alpha$，$0 < \alpha < 1$。实数 $u_\alpha$ 满足 $\text{Pr}(X > u_\alpha) = \alpha$，若 $\text{Pr}(|X| < x) = \alpha$，求 $x$。

### 解题步骤：

1.  **分析条件 $\text{Pr}(|X| < x) = \alpha$**

    根据绝对值的定义，不等式 $|X| < x$ 等价于 $-x < X < x$。因此，
    $$
    \text{Pr}(|X| < x) = \text{Pr}(-x < X < x)
    $$
    设 $\Phi(z)$ 为标准正态分布的累积分布函数 (CDF)，即 $\Phi(z) = \text{Pr}(X \le z)$。那么，
    $$
    \text{Pr}(-x < X < x) = \Phi(x) - \Phi(-x)
    $$
    由于标准正态分布的概率密度函数是关于 $y$ 轴对称的偶函数，其累积分布函数满足性质 $\Phi(-z) = 1 - \Phi(z)$。将此性质代入上式，可得：
    $$
    \text{Pr}(|X| < x) = \Phi(x) - (1 - \Phi(x)) = 2\Phi(x) - 1
    $$
    结合已知条件 $\text{Pr}(|X| < x) = \alpha$，我们得到方程：
    $$
    2\Phi(x) - 1 = \alpha
    $$
    解出 $\Phi(x)$，得：
    $$
    \Phi(x) = \frac{1 + \alpha}{2}
    $$

2.  **分析条件 $\text{Pr}(X > u_\alpha) = \alpha$**

    这个条件是上 $\alpha$ 分位数 $u_\alpha$ 的定义。同样可以用累积分布函数 $\Phi$ 来表示：
    $$
    \text{Pr}(X > u_\alpha) = 1 - \text{Pr}(X \le u_\alpha) = 1 - \Phi(u_\alpha)
    $$
    因此，我们有：
    $$
    1 - \Phi(u_\alpha) = \alpha
    $$
    解出 $\Phi(u_\alpha)$，得：
    $$
    \Phi(u_\alpha) = 1 - \alpha
    $$

3.  **建立 $x$ 与 $u_\alpha$ 的关系**

    从步骤 1 我们知道 $\text{Pr}(X \le x) = \Phi(x) = \frac{1 + \alpha}{2}$。
    这意味着 $x$ 是标准正态分布的上 $p$ 分位数，其中 $p$ 为右尾概率。
    $$
    p = \text{Pr}(X > x) = 1 - \text{Pr}(X \le x) = 1 - \Phi(x)
    $$
    代入 $\Phi(x)$ 的值：
    $$
    p = 1 - \frac{1 + \alpha}{2} = \frac{2 - (1 + \alpha)}{2} = \frac{1 - \alpha}{2}
    $$
    根据上分位数的定义，$x$ 是使得右尾概率为 $\frac{1 - \alpha}{2}$ 的点。因此，$x$ 可以表示为：
    $$
    x = u_{\frac{1 - \alpha}{2}}
    $$

### 结论：

最终求得 $x$ 的表达式为：
$$
x = u_{\frac{1 - \alpha}{2}}
$$ 

# 疑问
解答的最后一部分没有看懂，可能是我没有理解右尾概率或者参数 $u_{\alpha}$

1. $u_\alpha$ 的定义：$u_\alpha$ 是标准正态分布的上 $\alpha$ 分位数，满足 $P(X > u_\alpha) = \alpha$
2. 右尾概率：就是上分位数对应的概率，即 $P(X > x)$
3. 推导过程：
• 从 $P(|X| < x) = \alpha$ 得到 $\Phi(x) = \frac{1+\alpha}{2}$
• 那么右尾概率 $P(X > x) = 1 - \Phi(x) = 1 - \frac{1+\alpha}{2} = \frac{1-\alpha}{2}$
• 根据 $u_\alpha$ 的定义，$P(X > u_{\frac{1-\alpha}{2}}) = \frac{1-\alpha}{2}$
• 所以 $x = u_{\frac{1-\alpha}{2}}$


直观理解：

• $P(|X| < x) = \alpha$ 表示 $X$ 落在区间 $(-x, x)$ 的概率是 $\alpha$
• 由于正态分布的对称性，左右尾部概率相等，各为 $\frac{1-\alpha}{2}$
• 所以 $x$ 就是右尾概率为 $\frac{1-\alpha}{2}$ 的分位数

这个推导在你的笔记中关于标准正态分布性质的部分有理论基础，特别是 $\Phi(-a) = 1 - \Phi(a)$ 这个性质。
# 二
## 题目 
设随机变量 X 的概率密度函数为

$$
f(x) = \left\{
\begin{array}{ll}
\frac{1}{3x^{2/3}}, & x \in [1, 8] \\
0, & \text{其他}
\end{array}
\right.
$$

$F(x)$ 是分布函数，试求随机变量 $Y = F(x)$ 的分布函数。
## 解答
### 1. 先求 $F(x)$

$$
F(x) = \int_1^x \frac{1}{3 t^{2/3}} \, dt
= \left[ t^{1/3} \right]_{t=1}^{t=x}
= x^{1/3} - 1, \quad 1 \le x \le 8.
$$
所以：
$$
F(x) =
\begin{cases}
0, & x < 1, \\
x^{1/3} - 1, & 1 \le x \le 8, \\
1, & x > 8.
\end{cases}
$$

---

### 2. 定义 $Y = F(X)$

由于 $X$ 在 $[1,8]$ 内取值，  
$Y = X^{1/3} - 1$ 的取值范围是：
当 $X=1$ 时，$Y=0$；  
当 $X=8$ 时，$Y=2-1=1$。

所以 $Y \in [0,1]$。

---

### 3. 求 $Y$ 的分布函数 $G(y) = P(Y \le y)$

对于 $0 \le y \le 1$：
$$
Y \le y \ \iff\ F(X) \le y \ \iff\ X^{1/3} - 1 \le y \ \iff\ X^{1/3} \le y+1 \ \iff\ X \le (y+1)^3.
$$
因此：
$$
G(y) = P(X \le (y+1)^3) = F\big( (y+1)^3 \big).
$$
而 $(y+1)^3$ 在 $y \in [0,1]$ 时属于 $[1,8]$，所以：
$$
F\big( (y+1)^3 \big) = \big( (y+1)^3 \big)^{1/3} - 1 = (y+1) - 1 = y.
$$
所以：
$$
G(y) = y, \quad 0 \le y \le 1.
$$
当 $y < 0$ 时 $G(y) = 0$，当 $y > 1$ 时 $G(y) = 1$。

---

### 4. 结论

$Y$ 的分布函数是：
$$
G(y) =
\begin{cases}
0, & y < 0, \\
y, & 0 \le y \le 1, \\
1, & y > 1.
\end{cases}
$$
这正是 **均匀分布 $U(0,1)$** 的分布函数。

---

**最终答案：**
$$
\boxed{G(y) = y \ \ (0 \le y \le 1)}
$$
即 $Y \sim U(0,1)$。
