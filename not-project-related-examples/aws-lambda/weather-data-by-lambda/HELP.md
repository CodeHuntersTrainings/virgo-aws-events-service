1. Run: ./mvnw clean package
2. Upload the jar to AWS Lambda (not the original jar)
3. RUN: aws lambda invoke --function-name SecondLambdaExample --cli-binary-format raw-in-base64-out --payload '{"location": "Hungary"}' output.json

aws lambda invoke --function-name <function-name> --payload '<payload>' <output-file>

--payload '{"key1": "value1", "key2": "value2"}'
