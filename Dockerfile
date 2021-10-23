FROM python:3.8-slim

ADD . .

WORKDIR .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 2020

RUN mkdir -p /imgs/colorised

CMD ["gunicorn", "-w", "1","-b","0.0.0.0:2020", "demo_release:app" , "--timeout", "180"]