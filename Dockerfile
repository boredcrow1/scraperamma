FROM ubuntu:latest
WORKDIR /app

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y nano git python3 python3-pip curl

RUN apt-get install -y apt-transport-https
RUN curl https://ollama.ai/install.sh | bash
RUN git clone https://github.com/jmorganca/ollama/ && \
    mv ollama/examples/langchain-python-rag-privategpt ./ && \
    cd langchain-python-rag-privategpt && \
    pwd && \ 
    ls && \
    pip install -r requirements.txt

RUN mkdir source_documents
RUN apt-get install -y curl
RUN apt-get install -y git
RUN apt-get install -y sudo
RUN apt-get install -y tmux
RUN curl https://d18rn0p25nwr6d.cloudfront.net/CIK-0001813756/975b3e9b-268e-4798-a9e4-2a9a7c92dc10.pdf -o ./source_documents/wework.pdf

RUN pip install langchain tqdm chromadb sentence-transformers
RUN sudo rm -r ollama
RUN sudo mv ./source_documents ./langchain-python-rag-privategpt
CMD ["bash", "-c", "ollama serve &"]
CMD ["python3", "./langchain-python-rag-privategpt/ingest.py"]

CMD ["bash", "-c", "ollama serve"]
CMD ["bash"]
