FROM python:3.8-slim

ADD . .

WORKDIR .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 2020

CMD ["gunicorn", "-w", "1","-b","0.0.0.0:2020", "demo_release:app" , "--timeout", "180"]