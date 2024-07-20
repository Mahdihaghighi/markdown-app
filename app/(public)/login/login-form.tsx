"use client";

export default function LoinForm() {
  return (
    <div>
      <h1>Log In</h1>
      <form>
        <div>
          <label>UserName</label>
          <input id="username" name="username" type="text" />
        </div>
        <div>
          <label>PassWord</label>
          <input id="password" name="password" type="password" />
        </div>
        <button type="submit">submit</button>
      </form>
    </div>
  );
}
