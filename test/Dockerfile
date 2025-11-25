FROM mcr.microsoft.com/playwright:v1.56.1-noble

WORKDIR /home/pwuser/test

RUN npm install \
    @playwright/test@1.56.1 \
    @types/node@24.10.1

RUN echo "alias playwright='npx playwright'" >> ~/.bashrc

COPY . .

CMD ["npx", "playwright", "test"]
