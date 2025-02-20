# 使用Ubuntu 24.04作为基础镜像
FROM ubuntu:24.04

# 设置非交互式安装，避免卡住
ENV DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装必要的依赖
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    pkg-config \
    libssl-dev \
    protobuf-compiler \
    && apt-get clean

# 安装Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# 添加RISC-V目标（为guest program准备）
RUN rustup target add riscv32i-unknown-none-elf

# 设置工作目录
WORKDIR /root/.nexus

# 克隆Nexus网络API仓库
RUN git clone https://github.com/nexus-xyz/network-api.git

# 切换到最新tag
RUN cd network-api && git fetch --tags && git -c advice.detachedHead=false checkout "$(git rev-list --tags --max-count=1)"

# 编译CLI
RUN cd network-api/clients/cli && cargo build --release

# 将编译好的nexus-network移动到/root/.nexus/
RUN mv /root/.nexus/network-api/clients/cli/target/release/nexus-network /root/.nexus/nexus-network

# 清理源码目录
# RUN rm -rf network-api

# 确保nexus-network可执行
RUN chmod +x /root/.nexus/nexus-network

# 复制启动脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 设置环境变量
ENV NONINTERACTIVE=1
ENV RUST_BACKTRACE=full

# 入口点，运行entrypoint脚本
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/root/.nexus/nexus-network", "start", "--env", "beta"]
