![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/2cq87zi7z8d3gt8vifnm.png)

This is [my Github Profile](https://github.com/huantt). The specific thing here is that the weather is updated every 6 hours automatically.
`(I know that embedding weather in the readme does nothing; it's just for demonstration purposes in the 'Creating Dynamic README.md File')`

In this article, I will walk you through how I did that!
Let's get started!

## 1. What is Github Actions
GitHub Actions is a continuous integration and continuous delivery (CI/CD) platform that allows you to automate your build, test, and deployment pipeline. It's similar to Gitlab CI. In this project, I'm using Github Action to automatically update the weather in the README.md file.

## 2. Github Action Workflow triggers
Workflow triggers are events that cause a workflow to run. These events can be:
- Events that occur in your workflow's repository such as: 
  - Push
  - Pull request
  - Scheduled times
  - Manual

In this project, I'm using "Scheduled times" to trigger the Workflow "Update Weather."

## 3. Go template
Go templates are a powerful way to generate text, HTML, or any other output based on a predefined template structure. It's similar to templates in other frameworks like Laravel and template engines such as Pug.

(Data + Template) = Output

## 4. Combine them to make Readme up-to-date
- Implement a service to collect weather data (Data).
- Write a template that uses the above data as input.
- Run the Go Template to combine the template and data to generate the output.
- Commit and push the output changes.
- Write a Github action to run the above steps at intervals.

## Simply use my Github Action
Source code: [huantt/weather-forecast](Source code: https://github.com/huantt/weather-forecast)

I've wrapped the four steps above into a Github Action. You can easily use it by following these simple steps:

**Step 1:** In your repository, create a file named `README.md.template`.

**Step 2:** Write anything you want within the `README.md.template` file.

**Step 3:** Embed one of the following entities within your `README.md.template`:

- **Today's Weather Table:**
```shell
{{ template "hourly-table" $todayWeather.HourlyWeathers }}
```

- **Daily Weather Table:**
```shell
{{ template "daily-table" .Weathers }}
```

- **Updated at:**
```shell
{{ formatTime .UpdatedAt }}
```

If you are familiar with Go templates, you have access to the `root` variable, which includes the following fields:

- `Weathers`: An array of daily weather data. You can view the weather struct definition in [model/weather.go](model/weather.go).
- `UpdatedAt`: This field contains the timestamp in the format of `time.Date`.

**Step 4**: Register Github Action
- Create a file `.github/workflows/update-weather.yml` in your repository.

```yml
name: "Cronjob"
on:
  schedule:
    - cron: '15 * * * *'

jobs:
  update-weather:
    permissions: write-all
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Generate README
        uses: huantt/weather-forecast@v1.0.5
        with:
          city: HaNoi
          days: 7
          weather-api-key: ${{ secrets.WEATHER_API_KEY }}
          template-file: 'README.md.template'
          out-file: 'README.md'
      - name: Commit
        run: |
          if git diff --exit-code; then
            echo "No changes to commit."
            exit 0
          else
            git config user.name github-actions
            git config user.email github-actions@github.com
            git add .
            git commit -m "update"
            git push origin main
          fi
```

- Update some variables in this file:
  - city: The city for which you want to forecast the weather.
  - days: The number of forecast days.
  - template-file: The path to the above template file. Eg. `template/README.md.template`
  - out-file: Your README.md file name.
  - weather-api-key:
    - Register a free API key at [https://www.weatherapi.com](https://www.weatherapi.com).
    - Set up secrets with the name `WEATHER_API_KEY` in `Your repo > settings > Secrets and variables > Actions > New repository secret`.

**Step 5**: Commit your changes, and then Github actions will run at the specified cron interval to update the weather in your README.md file.

## Other Github Actions
- [Update your dev.to articles into your Github Profile](https://dev.to/jacktt/update-your-devto-articles-into-your-github-profile-4dpi)

## Reference
- [GitHub Actions Documentation](https://docs.github.com/en/actions/using-workflows/triggering-a-workflow)
- Source code: [huantt/weather-forecast](Source code: https://github.com/huantt/weather-forecast)