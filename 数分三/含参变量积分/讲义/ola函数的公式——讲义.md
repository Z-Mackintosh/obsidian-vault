
# 🔷 进阶讲义：伽马函数的三大重要公式  
## —— **勒让德倍元公式 · 余元公式 · 斯特林渐近公式**

---

我们将以“**问题驱动 + 直观解释 + 严格背景 + 典型应用**”的方式，系统展开。每一个公式都有其独特的数学美感和深刻作用。

---

## 一、Legendre 倍元公式（Legendre's Duplication Formula）

### 🌀 公式内容：

> $$
> \Gamma(s)\,\Gamma\left(s + \frac{1}{2}\right) = 2^{1-2s} \sqrt{\pi} \cdot \Gamma(2s),\quad s > 0
> $$

👉 什么叫“倍元”？指的是 **把参数 $2s$ 的 Γ 函数**，用 **两个相近参数的 Γ 乘积** 表达。

这在组合数学、特殊函数理论、近似计算中都很有用。

---

### 💡 为什么会出现这个公式？从哪里来？

灵感来源于 **贝塔函数的对称性质** 和 **积分换元技巧**。

简单来说，我们可以通过计算一个特定的 β 函数，并从两个角度表达它（一是直接，二是变量替换），从而导出该公式。

#### 【关键路径】
1. 利用贝塔函数关系：
   $$
   B(s,s) = \frac{\Gamma(s)^2}{\Gamma(2s)}
   $$
2. 同时我们知道，β 函数有三角表示：
   $$
   B(s,s) = 2\int_0^{\pi/2} (\sin \theta)^{2s-1} (\cos \theta)^{2s-1} d\theta = 2\int_0^{\pi/2} (\sin 2\theta)^{2s-1} \cdot |{\scriptsize ???}| d\theta
   $$
   更常用的是令 $x = \sin^2\theta$ 来还原。

但实际严谨推导涉及复杂的技巧（如高斯关于超几何函数的工作），在此略去完整证明，强调**理解与应用优先**。

---

### ✅ 应用举例：

#### 例：计算 $\Gamma\left (\frac{3}{4}\right)\Gamma\left (\frac{5}{4}\right)$

注意到：
- $s = \frac{3}{4}$
- $s + \frac{1}{2} = \frac{5}{4}$
- $2 s = \frac{3}{2}$

代入公式：
$$
\Gamma\left(\frac{3}{4}\right)\Gamma\left(\frac{5}{4}\right) = 2^{1 - 2\cdot 3/4} \sqrt{\pi} \cdot \Gamma\left(\frac{3}{2}\right)
= 2^{-1/2} \sqrt{\pi} \cdot \Gamma\left(\frac{3}{2}\right)
$$

而 $\Gamma (3/2) = \Gamma (1 + 1/2) = \frac{1}{2} \Gamma (1/2) = \frac{1}{2} \sqrt{\pi}$

所以：
$$
= \frac{1}{\sqrt{2}} \cdot \sqrt{\pi} \cdot \frac{1}{2} \sqrt{\pi} 
= \frac{\pi}{2\sqrt{2}}
$$

🎯 四分之三阶乘相关表达，就这样算出来了！

---

### 📘 简评：

- Legendre 公式是“函数方程”思想的经典体现。
- 它也属于更广的 **乘法公式**（Multiplication Theorem）的一种特例（$n=2$）。

> 更一般的 Gauss 乘法公式：
> $$
> \prod_{k=0}^{n-1} \Gamma\left(s + \frac{k}{n}\right) = (2\pi)^{(n-1)/2} n^{1/2 - ns} \Gamma(ns)
> $$
> 当 $n=2$：退回 Legendre 倍元公式！

---

## 二、余元公式（Reflection Formula / Euler's Reflection Formula）

### 🌀 公式内容：

> $$
> \Gamma(s)\,\Gamma(1 - s) = \frac{\pi}{\sin(\pi s)},\quad 0 < s < 1
> $$
>（可解析延拓至所有非整数 $s$）

⚠️ 这是伽马函数最出名、最美的对称恒等式之一！

---

### 💡 直观理解：“对称补整”

对于 $0 < s < 1$，$1-s$正好是$s$ 的“镜像”。  
这个公式告诉我们：

> 一个数 $s$和它的补$1-s$的 γ 函数乘积，等于$\pi / \sin(\pi s)$

例如：
- 若 $s \to 0^+$，$\Gamma(s) \sim \frac{1}{s},\ \Gamma(1-s) \to \Gamma(1) = 1$,  
  $\frac{\pi}{\sin(\pi s)} \sim \frac{\pi}{\pi s} = \frac{1}{s}$ → 两边一致
- 若 $s = 1/2$，左边 $\Gamma (1/2)^2 = (\sqrt{\pi})^2 = \pi$，右边 $\pi / \sin (\pi/2) = \pi/1 = \pi$：✅吻合！

所以公式行为良好。

---

### 🧠 怎么来？思想浅析

严格证明需要复变函数工具（比如利用正弦函数无穷乘积展开和Γ的 Weierstrass 表示），但我们可以通过以下线索理解：

#### 方法 1：用贝塔函数 + 换元法（初等途径）

回忆：
$$
B(s,1-s) = \int_0^1 x^{s-1}(1-x)^{-s}\,dx = \int_0^1 \left(\frac{x}{1-x}\right)^{s-1} \cdot \frac{1}{1-x} dx
$$

换元：令 $u = \frac{x}{1-x} \Rightarrow x = \frac{u}{1+u},\ dx = \frac{du}{(1+u)^2}$

当 $x: 0\to1$, 则 $u: 0\to\infty$

$$
B(s,1-s) = \int_0^\infty u^{s-1} \cdot \left( \frac{1}{1+x} \right) \cdot \frac{1}{(1+u)^2} \cdots ?
$$

最终得到：
$$
B(s,1-s) = \int_0^\infty \frac{u^{s-1}}{1+u} du
$$

这是个经典积分！其结果已知为：

$$
\int_0^\infty \frac{x^{s-1}}{1+x} dx = \frac{\pi}{\sin(\pi s)},\quad 0<s<1
$$

另一方面，由贝塔与伽马关系：
$$
B(s,1-s) = \frac{\Gamma(s)\Gamma(1-s)}{\Gamma(1)} = \Gamma(s)\Gamma(1-s)
$$

因此：
✅
$$
\boxed{\Gamma(s)\Gamma(1-s) = \frac{\pi}{\sin(\pi s)}}
$$

👏 完成推导！

---

### 🎯 应用举例

#### 例：计算 $\Gamma\left (\frac{1}{3}\right)\Gamma\left (\frac{2}{3}\right)$

利用余元公式：

- $s = 1/3 \Rightarrow 1-s = 2/3$
- 
$$
\Gamma(1/3)\Gamma(2/3) = \frac{\pi}{\sin(\pi/3)} = \frac{\pi}{\sqrt{3}/2} = \frac{2\pi}{\sqrt{3}}
$$

=> 所以只要测出 $\Gamma (1/3)$，就能知道 $\Gamma (2/3)$，反之亦然。

> 补充：这是一个**无法用初等函数表示**的无理数，但这个乘积我们知道！

---

### 📘 特色与用途总结：

| 项目 | 内容 |
|------|------|
| 是否仅限 $(0,1)$？ | 是定义域，但可通过解析延拓扩展 |
| 关键作用 | 给出负数或小于零位置的 γ 值 |
| 拓展意义 | 构成 γ 函数的**函数方程**（Functional Equation） |
| 连接领域 | 复分析、调和分析、黎曼 ζ 函数 |

---

## 三、斯特林公式（Stirling’s Approximation）

### 🌀 近似公式：

$$
\Gamma(s) \sim \sqrt{2\pi} \cdot s^{s - 1/2} \cdot e^{-s},\quad \text{as } s \to \infty^+
$$

当整数 $n\to\infty$，就写成常见形式：

$$
n! = \Gamma(n+1) \sim \sqrt{2\pi n} \left(\frac{n}{e}\right)^n
$$

✅ 我们称它为：**斯特林公式（Stirling's Formula）**

---

### 💡 它想告诉我们什么？

当 $n$ 很大时，阶乘增长极快，无法直接计算。

斯特林公式为我们提供一个**高效、高精度近似值**。

比如：
- $10! = 3,628,800$
- 估算：$\sqrt{2\pi \cdot 10} \left (\frac{10}{e}\right)^{10} \approx \sqrt{62.83} \cdot (3.678)^{10} \approx 7.928 \cdot 79384.6 \approx 3,546,760$

误差约 2.27% —— 对于粗略估算完全可以接受！

而且改进形式更高精度！

---

### 🔍 发展版本（带修正项）：

$$
n! \approx \sqrt{2\pi n} \left(\frac{n}{e}\right)^n \left(1 + \frac{1}{12n} + \frac{1}{288n^2} - \cdots \right)
$$

越高阶修正，越接近真实值。

---


### 📊 有哪些好处？为什么要学这个？

| 场景 | 应用 |
|------|------|
| 概率论 | 分析大样本分布，中心极限定理的支撑之一 |
| 统计物理 | 处理大量粒子组成的系统的配分函数 |
| 算法复杂度 | 估计排列组合数量级（如 $\binom{2n}{n}$） |
| 数列极限 | 解决形式 $\frac{n^n}{n!}$ 的收敛问题 |

---


## 五、思考挑战题（检测掌握程度）

### ⚔️ 练习 1：利用余元公式，求 $\Gamma (-1/2)$

提示：
- 首先用递推关系 $\Gamma (s+1) = s\Gamma (s)$
- 得：$\Gamma (-1/2) = ? \cdot \Gamma (1/2)$

解：
$$
\Gamma\left(\frac{1}{2}\right) = \Gamma\left(-\frac{1}{2} + 1\right) = \left(-\frac{1}{2}\right) \Gamma\left(-\frac{1}{2}\right)
\Rightarrow \sqrt{\pi} = -\frac{1}{2} \Gamma(-1/2)
\Rightarrow \Gamma(-1/2) = -2\sqrt{\pi}
$$

> 注：负分数可以有明确定义！

---

### ⚔️ 练习 2：估算 $100!$ 的数量级（阶位、科学计数）

用斯特林公式：
$$
100! \approx \sqrt{2\pi \cdot 100} \left(\frac{100}{e}\right)^{100}
= \sqrt{628.318} \cdot (36.7879)^{100}
\approx 25.066 \cdot (3.67879 \times 10^1)^{100}
= 25.066 \cdot 3.67879^{100} \cdot 10^{100}
$$

取对数计算幂次：

- $\lg (100!) \approx 100 \lg 100 - 100 \lg e + \frac{1}{2} \lg (200\pi)$
- $\lg e \approx 0.4343$
- $\lg 100 = 2$
- $\Rightarrow = 200 - 43.43 + 0.5 \times \lg (628.3) \approx 156.57 + 2.9/2 ≈ 156.57 + 1.45 = 158.02$

所以：$100! \sim 10^{158.02} \approx 1.05 \times 10^{158}$

✅ 实际 $100! \approx 9.33 \times 10^{157}$，误差不足 10%！惊人！

---

### ✨ 学习框架收尾图示：

```
                    含参积分
                       ↓
                   定义 Γ(s)
                   定义 B(p,q)
                       ↓
              基本性质：递推、对称
                       ↓
       ┌────────┬────────┴────────┬────────┐
      乘积       分析性质        Gamma      渐近估计
   Legendre      余元关系      函数家族     Stirling
              (函数方程视角)
```
