
## 题目
证明含参变量反常积分
$$ \int_{0}^{+\infty}\:x\sin\:x^{4}\cos\:\alpha x\mathrm{d}x\:,a\leqslant\alpha\leqslant b.$$
关于参数 $\alpha$ 在区间 $[a,b]$ 上一致收敛。
## 解答

### 证明步骤

#### 1. 变量代换

令 $t = x^4$，则 $x = t^{1/4}$，$dx = \frac{1}{4} t^{-3/4} dt$。

积分变为：

$$I(\alpha) = \int_{0}^{+\infty} t^{1/4} \sin t \cos (\alpha t^{1/4}) \cdot \frac{1}{4} t^{-3/4} \, dt = \frac{1}{4} \int_{0}^{+\infty} t^{-1/2} \sin t \cos (\alpha t^{1/4}) \, dt$$
#### 2. 使用 Dirichlet 判别法

设：
- $F(t) = \sin t$
- $G(t, \alpha) = t^{-1/2} \cos (\alpha t^{1/4})$

条件 1：$\left| \int_{A}^M F(t) dt \right|$ 一致有界

$$\left| \int_{A}^M \sin t \, dt \right| = |\cos A - \cos M| \leq 2$$

这与 $\alpha$ 无关，因此在 $[a, b]$ 上一致有界。

条件 2：对于每一个 $\alpha \in [a, b]$，$G(t, \alpha)$ 关于 $t$ 单调

条件 3：$G(t, \alpha)$ 关于 $t$ 的趋向于 0 是“一致”的。
### 结论
1. $\int_0^M \sin t \, dt$ 有界。

2. $\lim_{t \to +\infty} G(t, \alpha) = 0$ 对 $\alpha \in [a, b]$ 是一致的（因为 $|G| \leq t^{-1/2}$）。
   
3. $\frac{\partial G}{\partial t}$ 在 $[A, +\infty)$ 上关于 $\alpha$ 一致绝对可积。
  
根据 **含参变量积分的 Dirichlet 判别法**，该积分在 $\alpha \in [a, b]$ 上**一致收敛**。
