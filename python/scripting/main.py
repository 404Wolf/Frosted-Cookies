from selenium import webdriver

if __name__ == "__main__":
    driver = webdriver.Chrome()
    driver.get("https://example.com")
    print(driver.title)
    driver.quit()
