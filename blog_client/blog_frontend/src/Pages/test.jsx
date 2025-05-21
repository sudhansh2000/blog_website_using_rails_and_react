// import React, { useEffect, useRef } from 'react';
import EditorJS from '@editorjs/editorjs';
import Header from '@editorjs/header';
import SimpleImage from '@editorjs/simple-image';
import List from '@editorjs/list';
// import Checklist from '@editorjs/checklist';
// import Quote from '@editorjs/quote';
// import Warning from '@editorjs/warning';
// import Marker from '@editorjs/marker';
// import CodeTool from '@editorjs/code';
// import Delimiter from '@editorjs/delimiter';
// import InlineCode from '@editorjs/inline-code';
// import LinkTool from '@editorjs/link';
// import Embed from '@editorjs/embed';
// import Table from '@editorjs/table';
import ShowPostContent from '../Components/ShowPostContent';

const EditorPage = () => {
  // const data = {
  //   "time": 1747733925201,
  //   "blocks": [
  //     {
  //       "id": "HLYF13RLJ2",
  //       "type": "paragraph",
  //       "data": {
  //         "text": "this si new post"
  //       }
  //     },
  //     {
  //       "id": "fbVPKlKzX8",
  //       "type": "header",
  //       "data": {
  //         "text": "This si heading&nbsp;",
  //         "level": 2
  //       }
  //     },
  //     {
  //       "id": "EExUU2eWEm",
  //       "type": "paragraph",
  //       "data": {
  //         "text": "Winter is the peak tourist season. Seasonal cafes spring up, serving Tibetan, Thai and Burmese food. Roadside vendors appear, selling Buddha idols, Tibetan thangkas and prayer beads."
  //       }
  //     },
  //     {
  //       "id": "GC2tnYek20",
  //       "type": "paragraph",
  //       "data": {
  //         "text": "Despite the scorching summer, Bodh Gaya is at its busiest on&nbsp;Buddha Purnima, when thousands of people descend on the town to celebrate the birth of Buddhal. This year, Buddha Purnima falls on 23 May, and will see grand processions and ceremonial prayers. Bhante Dinanath Bhikhu, a monk at the Mahabodhi temple, estimates the arrival of 15,000 people in Bodh Gaya for the festival this year."
  //       }
  //     },
  //     {
  //       "id": "l5p_4l-TwT",
  //       "type": "paragraph",
  //       "data": {
  //         "text": "Here’s a handy guide on what to see, do and eat in Bodh Gaya:"
  //       }
  //     },
  //     {
  //       "id": "ZQ_rGToWH8",
  //       "type": "paragraph",
  //       "data": {
  //         "text": "In the absence of a Buddhist doctrine, Buddhism evolved into different schools across Asia. As monks and devotees from around the world began to visit Bodh Gaya, the countries they came from built monasteries to house them in. Today, Bodh Gaya is a microcosm of Buddhism across the continent, with Buddhist shrines built in varying architectural styles spread in a vast area around the Mahabodhi Temple."
  //       }
  //     },
  //     {
  //       "id": "Cq7cvSFGxz",
  //       "type": "list",
  //       "data": {
  //         "style": "unordered",
  //         "meta": {},
  //         "items": [
  //           {
  //             "content": "list 1",
  //             "meta": {},
  //             "items": []
  //           },
  //           {
  //             "content": "list 2",
  //             "meta": {},
  //             "items": []
  //           },
  //           {
  //             "content": "list 3",
  //             "meta": {},
  //             "items": []
  //           },
  //           {
  //             "content": "list 4",
  //             "meta": {},
  //             "items": []
  //           },
  //           {
  //             "content": "list 5",
  //             "meta": {},
  //             "items": []
  //           },
  //           {
  //             "content": "list 6",
  //             "meta": {},
  //             "items": []
  //           }
  //         ]
  //       }
  //     }
  //   ],
  //   "version": "2.31.0-rc.7"
  // }
  
  // const ejInstance = useRef(null);
  // const [content , setContent] = React.useState(null);

  // useEffect(() => {
  //   if (!ejInstance.current) {
  //     ejInstance.current = new EditorJS({
  //       /**
  //        * Tools list
  //        */
  //       readOnly: true,
  //       data: data,
  //       tools: {
  //         header: Header,
  //         image: SimpleImage,
  //         list: List,
  //         // checklist: Checklist,
  //         // quote: Quote,
  //         // warning: Warning,
  //         // marker: Marker,
  //         // code: CodeTool,
  //         // delimiter: Delimiter,
  //         // inlineCode: InlineCode,
  //         // linkTool: LinkTool,
  //         // embed: Embed,
  //         // table: Table
  //       },
      
  //       /**
  //        * Internationalzation config
  //        */
  //     });

  //     ejInstance.current.isReady
  //       .then(() => {
  //         console.log("Editor.js is ready to work!");
  //       })
  //       .catch((reason) => {
  //         console.log(`Editor.js initialization failed: ${reason}`);
  //       });
  //   }
  //   // Clean up on unmount
  //   return () => {
  //     if (ejInstance.current && ejInstance.current.destroy) {
  //       ejInstance.current.destroy();
  //       ejInstance.current = null;
  //     }
  //   };
  // }, [data]);

  // // ejInstance.save().then((outputData) => {
  // //   console.log('Article data: ', outputData)
  // // }).catch((error) => {
  // //   console.log('Saving failed: ', error)
  // // });
  // const savePost = async () => {
  //   ejInstance.current.save().then((outputData) => {
  //     setContent(outputData),
  //     console.log('Article data: ', outputData)
  //   }).catch((error) => {
  //     console.log('Saving failed: ', error)
  //   });
  // }
  return (
    <div>
      <ShowPostContent/>
    </div>
    // <div>
    //   <h1>This is working</h1>
    //   <div id="editorjs" />
    //   <button onClick={savePost}>save post</button>

    //   <div>
    //     <h2>Saved Content:</h2>
    //     {
    //       content && <pre>{JSON.stringify(content, null, 2)}</pre>
    //     } 
    //     {/* <pre>{EditorJS.render(content)}</pre> */}
    //   </div>

    // </div>
  );
};

export default EditorPage;
